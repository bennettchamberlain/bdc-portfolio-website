import 'dart:convert';
import 'dart:typed_data';

import 'package:bdc_website_v2/extensions/color_extension.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_alert_dialog_box/custom_alert_dialog_box.dart';
import 'package:file_picker/_internal/file_picker_web.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_dynamic_widget/json_dynamic_widget.dart';
import 'package:logger/logger.dart';
import 'package:quill_html_editor/quill_html_editor.dart';
import 'package:stacked/stacked.dart';
import 'package:bdc_website_v2/core/logger.dart';
import 'package:vrouter/vrouter.dart';

import '../../core/models/image_element.dart';
import '../../core/models/text_element.dart';
import '../../core/models/ui_element.dart';
import '../../services/storage_handler.dart';

class CreateBogViewModel extends BaseViewModel {
  late Logger log;
  String authorName = "", title = "asd", desc = "";
  late String type;
  final navigatorKey = GlobalKey<NavigatorState>();
  int prio = 0;

  //Handling images
  Uint8List? selectedImage = Uint8List(1);
  List<Uint8List?> selectedImages = [];
  List<String> selectedImagesUrl = [];
  late Stream<QuerySnapshot<Map<String, dynamic>>> getImages;
  late String thumnailImageUrl;
  bool isLoading = false;
  late BuildContext contextBuild;
  List<UIComponent> elements = [];
  late String text;
  String textAlignment = 'center';
  String selectedFontWeight = 'normal';
  double textFontSize = 8.0;
  String fontFamily = 'Primetime';
  String imageAlignment = 'center';
  double height = 100;
  double width = 100;
  // create some values
  Color pickerColor = Color(0xff443a49);
  Color currentColor = Color(0xff443a49);

  Future getImage(WidgetRef ref) async {
    FilePickerResult? result = await FilePickerWeb.platform.pickFiles(
      onFileLoading: (FilePickerStatus status) =>
          const CircularProgressIndicator.adaptive(),
      allowMultiple: false,
    );
    selectedImage = Uint8List(1);
    selectedImage = result!.files.single.bytes;
    selectedImages.add(selectedImage);
    final base64Str = base64.encode(selectedImage!);
    uploadImage(
        ref: ref,
        metadata: SettableMetadata(contentType: "image/jpeg"),
        refPath: title,
        dataUrl: base64Str,
        blog: title);
  }

  openTextEditor() async {
    await CustomAlertDialogBox.showCustomAlertBox(
      context: contextBuild,
      willDisplayWidget: StatefulBuilder(builder: (context, state) {
        return Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: "Enter Text",
              ),
              onChanged: (data) {
                text = data;
              },
            ),
            TextField(
              decoration: InputDecoration(
                hintText: "Enter Font",
              ),
              onChanged: (data) {
                textFontSize = double.parse(data);
              },
            ),
            DropdownButton<String>(
              value: fontFamily,
              onChanged: (String? newValue) {
                state(() {
                  fontFamily = newValue!;
                });
              },
              items: <String>[
                'Primetime',
                'Helvetica',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            DropdownButton<String>(
              value: textAlignment,
              onChanged: (String? newValue) {
                state(() {
                  textAlignment = newValue!;
                });
              },
              items: <String>[
                'center',
                'topLeft',
                'topRight',
                'bottomLeft',
                'bottomRight',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            DropdownButton<String>(
              value: selectedFontWeight,
              onChanged: (String? newValue) {
                state(() {
                  selectedFontWeight = newValue!;
                });
              },
              items: <String>[
                'bold',
                'normal',
                'w100',
                'w200',
                'w300',
                'w400',
                'w500',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            ColorPicker(
              pickerColor: pickerColor,
              onColorChanged: (Color color) {
                state(() {
                  pickerColor = color;
                });
              },
            ),
            TextButton(
                onPressed: () {
                  elements.add(TextWidget(
                      text: text,
                      priority: prio,
                      type: 'text',
                      font: textFontSize,
                      fontWeight: fontFamily,
                      colorHex: pickerColor.colorToHexString(pickerColor),
                      alignment: textAlignment));
                  //print((pickerColor.toHex()));
                  prio++;
                  notifyListeners();
                  Navigator.pop(context);
                },
                child: const Text("Add Text"))
          ],
        );
      }),
    );
  }

  openImageEditor(String url) async {
    await CustomAlertDialogBox.showCustomAlertBox(
      context: contextBuild,
      willDisplayWidget: StatefulBuilder(builder: (context, state) {
        return Column(
          children: [
            Image.network(url),
            TextField(
              decoration: InputDecoration(
                hintText: "Enter Height",
              ),
              onChanged: (data) {
                height = double.parse(data);
              },
            ),
            TextField(
              decoration: InputDecoration(
                hintText: "Enter Width",
              ),
              onChanged: (data) {
                width = double.parse(data);
              },
            ),
            DropdownButton<String>(
              value: textAlignment,
              onChanged: (String? newValue) {
                state(() {
                  imageAlignment = newValue!;
                });
              },
              items: <String>[
                'center',
                'topLeft',
                'topRight',
                'bottomLeft',
                'bottomRight',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            TextButton(
                onPressed: () {
                  elements.add(ImageWidget(
                      priority: prio,
                      type: 'image',
                      height: height,
                      url: url,
                      width: width,
                      alignment: textAlignment));
                  //print((pickerColor.toHex()));
                  prio++;
                  notifyListeners();
                  Navigator.pop(context);
                },
                child: const Text("Add Image"))
          ],
        );
      }),
    );
  }

  deleteImage(String id) async {
    isLoading = true;
    notifyListeners();
    await FirebaseFirestore.instance
        .collection('image_lib')
        .doc(id)
        .delete()
        .then((value) async {
      await CustomAlertDialogBox.showCustomAlertBox(
        context: contextBuild,
        willDisplayWidget: Container(
          child: const Text('Succesfully Deleted Image!'),
        ),
      );
      isLoading = false;
      notifyListeners();
    });
  }

  removeImageUrl(index) {
    selectedImagesUrl.removeAt(index);
    notifyListeners();
  }

  //Upload blog methods
  selectThumnail(String thumbnail) async {
    thumnailImageUrl = thumbnail;
    await CustomAlertDialogBox.showCustomAlertBox(
        context: contextBuild,
        willDisplayWidget: Container(
          child: const Text('Succesfully Selected Thumbnail!'),
        ));
  }

  getTextList() {
    var textList = [];
    for (int x = 0; x < elements.length; x++) {
      if (elements[x].type == 'text') {
        textList.add(elements[x].toJson());
      }
    }
    return textList;
  }

  getImageList() {
    var imageList = [];
    for (int x = 0; x < elements.length; x++) {
      if (elements[x].type == 'image') {
        imageList.add(elements[x].toJson());
      }
    }
    return imageList;
  }

  uploadBlog() async {
    isLoading = true;
    notifyListeners();
    String? htmlText = await controller.getText();
    await FirebaseFirestore.instance.collection(type).doc(title).set({
      'title': title,
      'author': authorName,
      'text': getTextList(),
      'image': getImageList(),
      'desc': '',
      'imgUrl': thumnailImageUrl,
      'id': title,
    }).then((value) async {
      await CustomAlertDialogBox.showCustomAlertBox(
        context: contextBuild,
        willDisplayWidget: Container(
          child: const Text('Succesfully Uploaded Blog!'),
        ),
      );
      isLoading = false;
      notifyListeners();
    });
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getBlogImages() {
    //get a stream of all documents in  collection

    return FirebaseFirestore.instance.collection('image_lib').snapshots();
  }

  //Quill Editor
  late QuillEditorController controller;
  final customToolBarList = [
    ToolBarStyle.bold,
    ToolBarStyle.italic,
    ToolBarStyle.underline,
    ToolBarStyle.strike,
    ToolBarStyle.blockQuote,
    ToolBarStyle.codeBlock,
    ToolBarStyle.indentMinus,
    ToolBarStyle.indentAdd,
    ToolBarStyle.headerOne,
    ToolBarStyle.headerTwo,
    ToolBarStyle.align,
    ToolBarStyle.color,
    ToolBarStyle.size,
    ToolBarStyle.link,
    ToolBarStyle.background,
    ToolBarStyle.video,
    ToolBarStyle.listBullet,
    ToolBarStyle.listOrdered,
    ToolBarStyle.clean,
    ToolBarStyle.undo,
    ToolBarStyle.redo,
    ToolBarStyle.addTable,
    ToolBarStyle.editTable,
  ];

  final toolbarColor = Colors.grey.shade200;
  final backgroundColor = Colors.white70;
  final toolbarIconColor = Colors.black87;
  final editorTextStyle = const TextStyle(
      fontSize: 18,
      color: Colors.black,
      fontWeight: FontWeight.normal,
      fontFamily: 'Architects Daughter');
  final hintTextStyle = const TextStyle(
      fontSize: 18, color: Colors.black12, fontWeight: FontWeight.normal);

  bool hasFocus = false;

  CreateBogViewModel(context) {
    contextBuild = context;
    log = getLogger(runtimeType.toString());
    type = VRouter.of(context).pathParameters['type']!;
    getImages = FirebaseFirestore.instance.collection('image_lib').snapshots();
    sortWidgets();
  }

  ///[insertNetworkImage] to set the html text to editor
  void insertNetworkImage(String url) async {
    await controller.embedImage(url);
  }

  void sortWidgets() {
    elements.sort((a, b) => a.getPriority().compareTo(b.getPriority()));
  }
}
