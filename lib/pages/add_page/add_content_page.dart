import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:image_picker_web/image_picker_web.dart';
import 'package:universal_io/io.dart';

import '../../utils/crud.dart';

class AddContentPage extends StatefulWidget {
  final String type;
  const AddContentPage({required this.type, super.key});

  @override
  State<AddContentPage> createState() => _AddContentPageState();
}

class _AddContentPageState extends State<AddContentPage> {
  String authorName = "", title = "", desc = "";
  Uint8List selectedImage = Uint8List(1);
  bool _isLoading = false;

  CrudMethods crudMethods = CrudMethods();

  Future getImage() async {
    Uint8List? bytesFromPicker = await ImagePickerWeb.getImageAsBytes();

    setState(() {
      selectedImage = bytesFromPicker ?? Uint8List(1);
    });
  }

  uploadBlog() async {
    String downloadUrl = '';
    if (selectedImage.length > 5) {
      //upload to firebase storage
      setState(() {
        _isLoading = true;
      });

      Reference storageRef = FirebaseStorage.instance
          .ref()
          .child("blogimages")
          .child(
              "${authorName}-${title}-${DateTime.now().millisecondsSinceEpoch}.jpg");

      File file = File.fromRawPath(selectedImage);

      await storageRef.putFile(File.fromRawPath(selectedImage));

      downloadUrl = await storageRef.getDownloadURL();
      print("this is url: $downloadUrl");

      Map<String, String> blogMap = {
        'imgUrl': downloadUrl,
        'authorName': authorName,
        'title': title,
        'desc': desc
      };
      crudMethods.addData(blogMap).then((result) {
        Navigator.pop(context);
      });
      //crudMethods.getBlogsData();
      setState(() {
        //blogsSnapshot = blogsSnapshot;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          GestureDetector(
            onTap: () {
              uploadBlog();
            },
            child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: const Icon(Icons.file_upload)),
          )
        ],
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Flutter",
              style: TextStyle(fontSize: 22),
            ),
            Text(
              "Blog",
              style: TextStyle(fontSize: 22, color: Colors.blue),
            )
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: _isLoading
          ? Container(
              alignment: Alignment.center, child: CircularProgressIndicator())
          : Container(
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      getImage();
                    },
                    child: selectedImage.length > 5
                        ? Container(
                            margin: const EdgeInsets.symmetric(horizontal: 16),
                            height: 250,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(6)),
                            child: Image.memory(
                              selectedImage,
                              fit: BoxFit.cover,
                            ),
                          )
                        : Container(
                            margin: const EdgeInsets.symmetric(horizontal: 16),
                            height: 250,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(6)),
                            child: const Icon(Icons.add_a_photo,
                                color: Colors.black45),
                          ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        TextField(
                          decoration:
                              const InputDecoration(hintText: "Author Name"),
                          onChanged: (val) {
                            authorName = val;
                          },
                        ),
                        TextField(
                          decoration: const InputDecoration(hintText: "Title"),
                          onChanged: (val) {
                            title = val;
                          },
                        ),
                        TextField(
                          decoration:
                              const InputDecoration(hintText: "Description"),
                          onChanged: (val) {
                            desc = val;
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
