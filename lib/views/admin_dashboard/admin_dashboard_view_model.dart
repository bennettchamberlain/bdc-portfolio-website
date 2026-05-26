import 'dart:convert';
import 'dart:typed_data';

import 'package:bdc_website_v2/models/blog/blog_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:bdc_website_v2/core/logger.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class AdminDashboardViewModel extends BaseViewModel {
  late Logger log;

  AdminDashboardViewModel() {
    log = getLogger(runtimeType.toString());
  }

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<String> uploadFile(String file, String fileName) async {
    firebase_storage.Reference storageReference = firebase_storage
        .FirebaseStorage.instance
        .ref()
        .child('resume/$fileName');

    firebase_storage.UploadTask uploadTask = storageReference.putString(file,
        metadata: SettableMetadata(contentType: "application/pdf"),
        format: PutStringFormat.base64);
    firebase_storage.TaskSnapshot taskSnapshot =
        await uploadTask.whenComplete(() {});

    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    print(downloadUrl);
    return downloadUrl;
  }

  Future<void> updateResumeDocument(String downloadUrl) async {
    try {
      CollectionReference collection = firestore.collection('resume');
      QuerySnapshot snapshot = await collection.limit(1).get();

      if (snapshot.docs.isNotEmpty) {
        DocumentSnapshot firstDocument = snapshot.docs[0];
        String documentId = firstDocument.id;
        await collection.doc(documentId).update({'url': downloadUrl});
        print('Document updated successfully.');
      } else {
        print('Document does not exist.');
      }
    } catch (error) {
      print('Error updating document: $error');
    }
  }

  void handleUploadButtonPressed() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowMultiple: false,
      allowedExtensions: ['pdf'],
    );

    if (result != null && result.files.isNotEmpty) {
      String fileName;

      List<int> fileBytes = result.files.first.bytes!;
      Uint8List uint8List =
          Uint8List.fromList(fileBytes); // Convert to Uint8List

      final base64Str = base64.encode(uint8List);
      fileName = result.files.first.name!;

      //Upload file and update resume document
      String downloadUrl = await uploadFile(base64Str, fileName);
      await updateResumeDocument(downloadUrl);
      print('Resume uploaded and document updated successfully.');
    } else {
      // No file selected or an error occurred
      print('No file selected.');
    }
  }

  // --- Content list + delete ---

  Stream<List<Blog>> getItemsStream(String type) {
    return FirebaseFirestore.instance
        .collection(type)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snap) =>
            snap.docs.map((d) => Blog.fromMap(d.data())).toList());
  }

  Future<void> confirmAndDelete(
      BuildContext context, String type, String id, String title) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Delete post?'),
        content: Text(
            'Are you sure you want to delete "$title"?\nThis cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      await FirebaseFirestore.instance.collection(type).doc(id).delete();
    }
  }
}
