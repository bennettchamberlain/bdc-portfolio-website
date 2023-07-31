import 'package:bdc_website_v2/core/models/ui_element.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class ImageWidget extends UIComponent {
  final String url;
  final double height;
  final double width;
  final String alignment;

  ImageWidget({
    required super.priority,
    required super.type,
    required this.alignment,
    required this.height,
    required this.width,
    required this.url,
  });

  @override
  int getPriority() {
    return super.getPriority();
  }

  @override
  String getType() {
    return super.getType();
  }

  toJson() {
    return {
      'alignment': alignment,
      'height': height,
      'width': width,
      'url': url,
      'priority': priority,
      'type': type
    };
  }

  factory ImageWidget.fromJson(Map<String, dynamic> json) {
    return ImageWidget(
        alignment: json['alignment'],
        height: json['height'],
        url: json['url'],
        width: json['width'],
        priority: json['priority'],
        type: json['type']);
  }

  Alignment _getAllignment() {
    switch (alignment) {
      case 'center':
        return Alignment.center;
      case 'topLeft':
        return Alignment.topLeft;
      case 'topRight':
        return Alignment.topRight;
      case 'bottomLeft':
        return Alignment.bottomLeft;
      case 'bottomRight':
        return Alignment.bottomRight;
      default:
        return Alignment.center;
    }
  }

  @override
  Widget getWidget() {
    return Image.network(url,
        height: height, width: width, alignment: _getAllignment());
  }
}
