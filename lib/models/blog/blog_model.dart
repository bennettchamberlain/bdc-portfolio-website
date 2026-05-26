import 'package:bdc_website_v2/core/models/content_block.dart';
import 'package:bdc_website_v2/core/models/image_element.dart';
import 'package:bdc_website_v2/core/models/text_element.dart';
import 'package:bdc_website_v2/core/models/ui_element.dart';

class Blog {
  String authorName;
  String desc;
  String id;
  String title;
  String imgUrl;
  DateTime? createdAt;

  /// New unified block list — populated for docs saved with the new editor.
  List<ContentBlock> blocks;

  /// Legacy fields kept for backward-compat with old Firestore docs.
  List<TextWidget>? textElements;
  List<ImageWidget>? imageElements;

  Blog({
    required this.authorName,
    required this.id,
    required this.imgUrl,
    required this.desc,
    required this.title,
    this.createdAt,
    List<ContentBlock>? blocks,
    this.imageElements,
    this.textElements,
  }) : blocks = blocks ?? [];

  factory Blog.fromMap(Map<String, dynamic> json) {
    // New format: blocks array
    if (json['blocks'] != null) {
      final rawBlocks = json['blocks'] as List<dynamic>;
      return Blog(
        authorName: json['author'] as String? ?? json['authorName'] as String? ?? '',
        desc: json['desc'] as String? ?? '',
        title: json['title'] as String? ?? '',
        id: json['id'] as String? ?? '',
        imgUrl: json['imgUrl'] as String? ?? json['thumbnailUrl'] as String? ?? '',
        createdAt: json['createdAt'] != null
            ? (json['createdAt'] as dynamic).toDate()
            : null,
        blocks: rawBlocks
            .map((e) => ContentBlock.fromJson(Map<String, dynamic>.from(e as Map)))
            .toList(),
      );
    }

    // Legacy format: separate text[] and image[] arrays
    List<TextWidget> textWidgets = [];
    List<ImageWidget> imageWidgets = [];
    final textList = json['text'] as List<dynamic>? ?? [];
    final imageList = json['image'] as List<dynamic>? ?? [];
    for (final t in textList) {
      textWidgets.add(TextWidget.fromJson(Map<String, dynamic>.from(t as Map)));
    }
    for (final i in imageList) {
      imageWidgets.add(ImageWidget.fromJson(Map<String, dynamic>.from(i as Map)));
    }

    // Migrate legacy elements into ContentBlocks so the viewer stays unified
    List<UIComponent> all = [...textWidgets, ...imageWidgets];
    all.sort((a, b) => a.getPriority().compareTo(b.getPriority()));
    final migratedBlocks = all.map((e) {
      if (e is TextWidget) {
        return ContentBlock(
          id: '${e.priority}',
          type: ContentBlockType.paragraph,
          content: e.text,
          align: e.alignment,
          fontSize: e.font,
          fontWeight: e.fontWeight,
          fontFamily: e.fontFamily,
          colorHex: e.colorHex,
        );
      } else if (e is ImageWidget) {
        return ContentBlock(
          id: '${e.priority}',
          type: ContentBlockType.image,
          url: e.url,
        );
      }
      return ContentBlock.paragraph();
    }).toList();

    return Blog(
      authorName: json['author'] as String? ?? json['authorName'] as String? ?? '',
      desc: json['desc'] as String? ?? '',
      title: json['title'] as String? ?? '',
      id: json['id'] as String? ?? '',
      imgUrl: json['imgUrl'] as String? ?? '',
      blocks: migratedBlocks,
      imageElements: imageWidgets,
      textElements: textWidgets,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'author': authorName,
      'desc': desc,
      'title': title,
      'id': id,
      'imgUrl': imgUrl,
      'createdAt': createdAt,
      'blocks': blocks.map((b) => b.toJson()).toList(),
    };
  }

  /// Legacy helper kept so existing BlogDetailsView still compiles.
  List<UIComponent> getAllUIElements() {
    List<UIComponent> elements = [...?textElements, ...?imageElements];
    elements.sort((a, b) => a.getPriority().compareTo(b.getPriority()));
    return elements;
  }
}
