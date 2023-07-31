import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/storage_handler.dart';

class UploadWidget extends ConsumerWidget {
  const UploadWidget({super.key, required this.item});
  final int item;



  @override
   Widget build(BuildContext context, WidgetRef ref) {
     final uploadProgress = ref.watch(uploadProgressProvider)[item]; 
     print('uploadProgress: $uploadProgress');
     
      return Column(
          children: [
            Text('Upload Progress: ${(uploadProgress * 100).toStringAsFixed(2)}%'),
           
             
          ],
        );
   
  }
}
