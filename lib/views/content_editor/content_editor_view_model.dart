import 'dart:convert';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';

import '../../core/logger.dart';
import '../../core/models/content_block.dart';

class ContentEditorViewModel extends BaseViewModel {
  late Logger log;
  late String type;
  late BuildContext contextBuild;

  String authorName = '';
  String title = '';
  String desc = '';
  String thumbnailUrl = '';

  bool isLoading = false;
  bool isSaved = false;
  bool isEditMode = false;
  String? editId;

  /// Upload progress for the currently uploading image/video (0–1).
  double uploadProgress = 0;
  String? uploadingBlockId;

  List<ContentBlock> blocks = [];

  ContentEditorViewModel(BuildContext context) {
    log = getLogger(runtimeType.toString());
    contextBuild = context;
    type = GoRouterState.of(context).pathParameters['type']!;
    final maybeId = GoRouterState.of(context).pathParameters['id'];
    if (maybeId != null && maybeId.isNotEmpty) {
      editId = maybeId;
      isEditMode = true;
      Future.microtask(() => loadExisting(maybeId));
    }
  }

  // --- Block manipulation ---

  Future<void> loadExisting(String docId) async {
    isLoading = true;
    notifyListeners();
    try {
      final doc = await FirebaseFirestore.instance
          .collection(type)
          .doc(docId)
          .get();
      if (!doc.exists) {
        _showSnack('Post not found.');
        isLoading = false;
        notifyListeners();
        return;
      }
      final data = doc.data()!;
      title = data['title'] as String? ?? '';
      authorName =
          data['author'] as String? ?? data['authorName'] as String? ?? '';
      desc = data['desc'] as String? ?? '';
      thumbnailUrl =
          data['imgUrl'] as String? ?? data['thumbnailUrl'] as String? ?? '';
      final rawBlocks = data['blocks'] as List<dynamic>? ?? [];
      blocks = rawBlocks
          .map((e) =>
              ContentBlock.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList();
    } catch (e) {
      log.e('Load failed: $e');
      _showSnack('Failed to load post: $e');
    }
    isLoading = false;
    notifyListeners();
  }

  // --- Block manipulation ---

  void addBlock(ContentBlock block) {
    blocks.add(block);
    notifyListeners();
  }

  void insertBlockAfter(String afterId, ContentBlock block) {
    final idx = blocks.indexWhere((b) => b.id == afterId);
    if (idx >= 0) {
      blocks.insert(idx + 1, block);
    } else {
      blocks.add(block);
    }
    notifyListeners();
  }

  void updateBlock(String id, ContentBlock updated) {
    final idx = blocks.indexWhere((b) => b.id == id);
    if (idx >= 0) {
      blocks[idx] = updated;
      notifyListeners();
    }
  }

  void removeBlock(String id) {
    blocks.removeWhere((b) => b.id == id);
    notifyListeners();
  }

  void reorderBlocks(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) newIndex--;
    final item = blocks.removeAt(oldIndex);
    blocks.insert(newIndex, item);
    notifyListeners();
  }

  void setThumbnail(String url) {
    thumbnailUrl = url;
    notifyListeners();
  }

  // --- Image upload for a block ---

  Future<void> pickAndUploadImage(WidgetRef ref, String blockId) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.image,
    );
    if (result == null) return;

    final bytes = result.files.single.bytes;
    if (bytes == null) return;

    await _uploadFileToBlock(
      blockId: blockId,
      bytes: bytes,
      contentType: 'image/jpeg',
      storagePath: 'content/$type/${DateTime.now().millisecondsSinceEpoch}',
      onComplete: (url) {
        updateBlock(blockId, blocks.firstWhere((b) => b.id == blockId).copyWith(url: url));
      },
    );
  }

  Future<void> pickAndUploadVideo(WidgetRef ref, String blockId) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.video,
    );
    if (result == null) return;

    final bytes = result.files.single.bytes;
    if (bytes == null) return;

    await _uploadFileToBlock(
      blockId: blockId,
      bytes: bytes,
      contentType: 'video/mp4',
      storagePath: 'content/$type/videos/${DateTime.now().millisecondsSinceEpoch}',
      onComplete: (url) {
        updateBlock(blockId, blocks.firstWhere((b) => b.id == blockId).copyWith(url: url));
      },
    );
  }

  Future<void> _uploadFileToBlock({
    required String blockId,
    required Uint8List bytes,
    required String contentType,
    required String storagePath,
    required void Function(String url) onComplete,
  }) async {
    isLoading = true;
    uploadProgress = 0;
    uploadingBlockId = blockId;
    notifyListeners();

    final base64Str = base64.encode(bytes);
    final ref = FirebaseStorage.instance.ref(storagePath);
    final task = ref.putString(
      base64Str,
      format: PutStringFormat.base64,
      metadata: SettableMetadata(contentType: contentType),
    );

    task.snapshotEvents.listen((event) {
      uploadProgress = event.bytesTransferred / event.totalBytes;
      notifyListeners();
    });

    await task;
    final url = await ref.getDownloadURL();
    onComplete(url);

    isLoading = false;
    uploadProgress = 0;
    uploadingBlockId = null;
    notifyListeners();
  }

  // --- Thumbnail (pick from existing image blocks or upload fresh) ---

  List<String> get imageUrls => blocks
      .where((b) => b.type == ContentBlockType.image && (b.url ?? '').isNotEmpty)
      .map((b) => b.url!)
      .toList();

  Future<void> pickAndUploadThumbnail(WidgetRef ref) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.image,
    );
    if (result == null) return;
    final bytes = result.files.single.bytes;
    if (bytes == null) return;

    isLoading = true;
    notifyListeners();

    final base64Str = base64.encode(bytes);
    final storageRef = FirebaseStorage.instance
        .ref('content/$type/thumbnails/${DateTime.now().millisecondsSinceEpoch}');
    await storageRef.putString(
      base64Str,
      format: PutStringFormat.base64,
      metadata: SettableMetadata(contentType: 'image/jpeg'),
    );
    thumbnailUrl = await storageRef.getDownloadURL();
    isLoading = false;
    notifyListeners();
  }

  // --- Save to Firestore ---

  Future<bool> save() async {
    if (title.trim().isEmpty) {
      _showSnack('Please enter a title before saving.');
      return false;
    }

    isLoading = true;
    notifyListeners();

    try {
      final docId = editId ?? title.trim().replaceAll(' ', '_').toLowerCase();
      final data = <String, dynamic>{
        'author': authorName,
        'authorName': authorName,
        'title': title,
        'desc': desc,
        'id': docId,
        'imgUrl': thumbnailUrl,
        'thumbnailUrl': thumbnailUrl,
        'updatedAt': FieldValue.serverTimestamp(),
        'blocks': blocks.map((b) => b.toJson()).toList(),
      };
      if (!isEditMode) {
        data['createdAt'] = FieldValue.serverTimestamp();
      }
      await FirebaseFirestore.instance
          .collection(type)
          .doc(docId)
          .set(data, SetOptions(merge: true));
      editId = docId;
      isEditMode = true;
      isSaved = true;
    } catch (e) {
      log.e('Save failed: $e');
      _showSnack('Save failed: $e');
      isLoading = false;
      notifyListeners();
      return false;
    }

    isLoading = false;
    notifyListeners();
    return true;
  }

  void _showSnack(String msg) {
    ScaffoldMessenger.of(contextBuild)
        .showSnackBar(SnackBar(content: Text(msg)));
  }
}
