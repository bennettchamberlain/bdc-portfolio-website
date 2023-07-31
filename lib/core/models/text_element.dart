import 'package:bdc_website_v2/core/models/ui_element.dart';
import 'package:bdc_website_v2/extensions/color_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hexcolor/hexcolor.dart' as HexColor;

class TextWidget extends UIComponent {
  final String text;
  final double font;
  final String fontWeight;
  final String colorHex;
  final String alignment;
  final String? fontFamily;
  TextWidget({
    this.fontFamily,
    required this.text,
    required super.priority,
    required super.type,
    required this.font,
    required this.fontWeight,
    required this.colorHex,
    required this.alignment,
  });

  @override
  int getPriority() {
    return super.getPriority();
  }

  factory TextWidget.fromJson(Map<String, dynamic> json) {
    return TextWidget(
        text: json['text'],
        font: json['font'].toDouble(),
        fontWeight: json['fontWeight'],
        colorHex: json['colorHex'],
        alignment: json['alignment'],
        fontFamily: json['fontFamily'],
        priority: json['priority'],
        type: json['type']);
  }

  toJson() {
    return {
      'text': text,
      'font': font,
      'fontWeight': fontWeight,
      'colorHex': colorHex,
      'alignment': alignment,
      'fontFamily': _getFontFamily(),
      'priority': priority,
      'type': type,
    };
  }

  String getType() {
    return super.getType();
  }

  FontWeight _getFontWeight() {
    switch (fontWeight) {
      case 'bold':
        return FontWeight.bold;
      case 'normal':
        return FontWeight.normal;
      case 'w100':
        return FontWeight.w100;
      case 'w200':
        return FontWeight.w200;
      case 'w300':
        return FontWeight.w300;
      case 'w400':
        return FontWeight.w400;
      case 'w500':
        return FontWeight.w500;

      default:
        return FontWeight.normal;
    }
  }

  TextAlign _getTextAlign() {
    switch (alignment) {
      case 'center':
        return TextAlign.center;
      case 'left':
        return TextAlign.left;
      case 'right':
        return TextAlign.right;
      case 'justify':
        return TextAlign.justify;
      default:
        return TextAlign.center;
    }
  }

  String _getFontFamily() {
    switch (fontFamily) {
      case 'Primetime':
        return 'Primetime';
      case 'Roboto':
        return 'Roboto';
      case 'RobotoMono':
        return 'RobotoMono';
      case 'RobotoSlab':
        return 'RobotoSlab';

      default:
        return 'Helvetica';
    }
  }

  @override
  Widget getWidget() {
    return MyWidget(
      widget: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Text(
          text,
          textAlign: _getTextAlign(),
          style: TextStyle(
            fontFamily: _getFontFamily(),
            fontSize: font,
            fontWeight: _getFontWeight(),
            color: HexColor.HexColor(colorHex),
          ),
        ),
      ),
    );
  }
}

class MyWidget extends StatelessWidget {
  final Widget widget;
  const MyWidget({super.key, required this.widget});

  @override
  Widget build(BuildContext context) {
    return widget;
  }
}
