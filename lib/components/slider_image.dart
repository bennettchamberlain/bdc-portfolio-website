import 'package:flutter/material.dart';

class SliderImage extends StatelessWidget {
  final String imageUrl;
  const SliderImage({
    required this.imageUrl,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Image.network(
      imageUrl,
      height: 500,
      width: double.infinity,
      fit: BoxFit.cover,
    );
  }
}
