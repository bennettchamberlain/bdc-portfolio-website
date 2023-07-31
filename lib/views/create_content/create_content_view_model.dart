import 'dart:convert';
import 'dart:typed_data'; 
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_alert_dialog_box/custom_alert_dialog_box.dart';
import 'package:file_picker/_internal/file_picker_web.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:bdc_website_v2/core/logger.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:vrouter/vrouter.dart';

import '../../core/locator.dart';
import '../../services/storage_handler.dart';
import '../../utils/crud.dart';

class CreateContentViewModel extends BaseViewModel {
  late Logger log;
  late String type;

  CreateContentViewModel(context) {
    log = getLogger(runtimeType.toString());
   contextBuild = context;
    type = VRouter.of(context).pathParameters['type']!;
  }

  String authorName = "", title = "", desc = "";
  Uint8List? selectedImage = Uint8List(1);
  List<Uint8List?> selectedImages = [];
  CrudMethods crudMethods = CrudMethods();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final _dialogService = locator<DialogService>();
  bool isLoading = false;
  int selectedThumbnail = 0;
  BuildContext? contextBuild;
  

  Future getImage(WidgetRef ref) async {
    FilePickerResult? result = await FilePickerWeb.platform.pickFiles(
      allowMultiple: true,
    );
    selectedImage = result!.files.single.bytes;
    selectedImages.add(selectedImage);
    final base64Str = base64.encode(selectedImage!);
    ref.read(selectedImageProvider.notifier).state =
        selectedImages.map((e) => base64.encode(e!)).toList();
    notifyListeners();
  }

  removeImage(index) {
    selectedImages.removeAt(index);
    notifyListeners();
  }

  selectThumbnail(index) {
    selectedThumbnail = index;
    notifyListeners();
  }

  uploadBlog(WidgetRef ref) async {
    isLoading = true;
    notifyListeners();
    List<String> urls = await uploadTask(
        ref: ref,
        metadata: SettableMetadata(contentType: "image/jpeg"),
        refPath: "blogImage$title");

    firestore.collection(type).doc(title).set({
      "authorName": authorName,
      "title": title,
      "desc": desc,
      "imgUrl": urls[selectedThumbnail],
      "otherImages": urls,
      "id" : title,
      "time": DateTime.now()
    }).then((value) async {
     await CustomAlertDialogBox.showCustomAlertBox(
    context: ref.context,
    willDisplayWidget: Container(
        child: const Text('Succesfully Uploaded Blog!'),
    ),
);
      isLoading = false;
      notifyListeners();
    });

    // String downloadUrl = '';                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   
    // if (selectedImage.length > 5) {
    //   //upload to firebase storage

    //   isLoading = true;
    //   notifyListeners();

    //   Reference storageRef = FirebaseStorage.instance
    //       .ref()
    //       .child("blogimages")
    //       .child(
    //           "$authorName-$title-${DateTime.now().millisecondsSinceEpoch}.jpg");

    //   await storageRef.putFile(File.fromRawPath(selectedImage));

    //   downloadUrl = await storageRef.getDownloadURL();
    //   print("this is url: $downloadUrl");

    //   //crudMethods.getBlogsData();
    // }
  }
}
