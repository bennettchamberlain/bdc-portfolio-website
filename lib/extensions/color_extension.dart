import 'package:flutter/material.dart';

extension HexColor on Color {
  colorToHexString(Color color) {
    return '#FF${color.value.toRadixString(16).substring(2, 8)}';
  }

  hexStringToColor(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return Color(int.parse(hexColor, radix: 16));
  }
}
