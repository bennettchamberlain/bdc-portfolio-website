import 'package:flutter/material.dart';

enum ContentBlockType { heading, paragraph, image, video, code, divider }

class ContentBlock {
  final String id;
  final ContentBlockType type;

  // heading / paragraph / code
  final String? content;

  // heading level: 1, 2, 3
  final int? level;

  // paragraph / heading
  final String? align; // left | center | right | justify
  final double? fontSize;
  final String? fontWeight; // bold | normal | w100…w500
  final String? fontFamily;
  final String? colorHex;

  // image / video
  final String? url;
  final String? caption;

  // code
  final String? language;

  ContentBlock({
    required this.id,
    required this.type,
    this.content,
    this.level,
    this.align,
    this.fontSize,
    this.fontWeight,
    this.fontFamily,
    this.colorHex,
    this.url,
    this.caption,
    this.language,
  });

  ContentBlock copyWith({
    String? id,
    ContentBlockType? type,
    String? content,
    int? level,
    String? align,
    double? fontSize,
    String? fontWeight,
    String? fontFamily,
    String? colorHex,
    String? url,
    String? caption,
    String? language,
  }) {
    return ContentBlock(
      id: id ?? this.id,
      type: type ?? this.type,
      content: content ?? this.content,
      level: level ?? this.level,
      align: align ?? this.align,
      fontSize: fontSize ?? this.fontSize,
      fontWeight: fontWeight ?? this.fontWeight,
      fontFamily: fontFamily ?? this.fontFamily,
      colorHex: colorHex ?? this.colorHex,
      url: url ?? this.url,
      caption: caption ?? this.caption,
      language: language ?? this.language,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type.name,
      if (content != null) 'content': content,
      if (level != null) 'level': level,
      if (align != null) 'align': align,
      if (fontSize != null) 'fontSize': fontSize,
      if (fontWeight != null) 'fontWeight': fontWeight,
      if (fontFamily != null) 'fontFamily': fontFamily,
      if (colorHex != null) 'colorHex': colorHex,
      if (url != null) 'url': url,
      if (caption != null) 'caption': caption,
      if (language != null) 'language': language,
    };
  }

  factory ContentBlock.fromJson(Map<String, dynamic> json) {
    final type = ContentBlockType.values.firstWhere(
      (e) => e.name == json['type'],
      orElse: () => ContentBlockType.paragraph,
    );
    return ContentBlock(
      id: json['id'] as String? ?? UniqueKey().toString(),
      type: type,
      content: json['content'] as String?,
      level: (json['level'] as num?)?.toInt(),
      align: json['align'] as String?,
      fontSize: (json['fontSize'] as num?)?.toDouble(),
      fontWeight: json['fontWeight'] as String?,
      fontFamily: json['fontFamily'] as String?,
      colorHex: json['colorHex'] as String?,
      url: json['url'] as String?,
      caption: json['caption'] as String?,
      language: json['language'] as String?,
    );
  }

  // --- Defaults for new blocks ---
  factory ContentBlock.heading({int level = 1}) => ContentBlock(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        type: ContentBlockType.heading,
        content: '',
        level: level,
        align: 'left',
        colorHex: '#000000',
      );

  factory ContentBlock.paragraph() => ContentBlock(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        type: ContentBlockType.paragraph,
        content: '',
        align: 'left',
        fontSize: 16,
        fontWeight: 'normal',
        fontFamily: 'Helvetica',
        colorHex: '#000000',
      );

  factory ContentBlock.image({String url = '', String caption = ''}) =>
      ContentBlock(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        type: ContentBlockType.image,
        url: url,
        caption: caption,
      );

  factory ContentBlock.video({String url = ''}) => ContentBlock(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        type: ContentBlockType.video,
        url: url,
        caption: '',
      );

  factory ContentBlock.code({String language = 'dart'}) => ContentBlock(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        type: ContentBlockType.code,
        content: '',
        language: language,
      );

  factory ContentBlock.divider() => ContentBlock(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        type: ContentBlockType.divider,
      );
}
