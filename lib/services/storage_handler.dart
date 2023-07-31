// ignore_for_file: use_function_type_syntax_for_parameters

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final storageProvider = Provider<FirebaseStorage>((ref) {
  return FirebaseStorage.instance;
});

//State Provider which stores the real-time update progress of all the files avaialble for uploading
final uploadProgressProvider = StateProvider<List<double>>((ref) {
  return List<double>.filled(8, 0);
});

//State Provider to store the upload progress of a single image
final singleUploadProgressProvider = StateProvider<double>((ref) {
  return 0;
});

//State Provider which stores all the selected files as a base64 string list
final selectedImageProvider = StateProvider<List<String>>((ref) {
  // Provide your file instance here
  return List<String>.filled(8, '');
});

//Method that takes in metadata of the file to be uploaded, the reference path and the widget ref (widget ref is used to access state providers)
uploadTask(
    {required WidgetRef ref,
    required SettableMetadata metadata,
    required String refPath}) async {
  final refs = ref.watch(selectedImageProvider.notifier).state;
  final storage = ref.watch(storageProvider);
  List<String> urls = [];

  for (int x = 0; x < refs.length; x++) {
    String dataUrl = refs[x];
    final task = await storage
        .ref(refPath)
        .child("${DateTime.now().millisecondsSinceEpoch}")
        .putString(
          metadata: metadata,
          dataUrl,
          format: PutStringFormat.base64,
        );

    //reading the state variable and updating it with the new progress
    List<double> oldState = ref.read(uploadProgressProvider);
    oldState[x] = (task.bytesTransferred / task.totalBytes);
    ref.read(uploadProgressProvider.notifier).state = [...oldState];

    print("state $x}: ${ref.read(uploadProgressProvider.notifier).state}");

    // The final snapshot is also available on the task via `.snapshot`,
    // this can include 2 additional states, `TaskState.error` & `TaskState.canceled`

    final url = await task.ref.getDownloadURL();
    //returning the url of the uploaded file
    urls.add(url);
  }

  return urls;
}

//Upload single Image

uploadImage(
    {required WidgetRef ref,
    required SettableMetadata metadata,
    required String refPath,
    required String dataUrl,
    required String blog}) async {
  final singleImageProgress = ref.watch(singleUploadProgressProvider.notifier);
  final storage = ref.watch(storageProvider);
    final doc =    FirebaseFirestore.instance.collection('image_lib').doc();

   storage
      .ref('imageslib').child(doc.id)
      
      .putString( 
        metadata: metadata,
        dataUrl,
        format: PutStringFormat.base64,
      )
      .snapshotEvents
      .listen((event) {
    singleImageProgress.state = event.bytesTransferred / event.totalBytes;
  });
 
 while (singleImageProgress.state != 1) {
  print("waiting");
    await Future.delayed(const Duration(seconds: 2));
  }
  storage .ref('imageslib').child(doc.id).getDownloadURL().then((url) async {
      print(url);
       await FirebaseFirestore.instance.collection('image_lib').doc(doc.id).set({'url': url, 'blog': blog});

  // Check if the document exists
  // final docSnapshot = await docRef.get();
  // if (docSnapshot.exists) {
  //   // Document exists, append images to the existing array
  //   final existingImages = (docSnapshot.data() as Map<String, dynamic>)['images'] as List<dynamic>? ?? [];
  //   final updatedImages = [...existingImages, url];

  //   await docRef.update({'images': updatedImages});
  // } else {
  //   // Document doesn't exist, create a new document with the images array
  //   await docRef.set({'images': [url]});
  // }
  singleImageProgress.state = 0;  //resetting the progress to 0
    });
}
