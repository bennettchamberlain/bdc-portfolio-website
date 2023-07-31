import 'package:flutter/material.dart';

enum BlogPosts {
  BlogPost1(
      title: "Mr Brainwash Art Museum Ticketing System",
      imagePath: "assets/images/pic2.jpeg",
      blogDescription: "My name is bennett and this is what im about",
      blogContent: [],
      path: "post-1"),
  BlogPost2(
      title: "Mr Brainwash Paints",
      imagePath: "assets/images/pic1.jpeg",
      blogDescription:
          "My name is bennhhh hhhhhkkkkfk  kf kf kf k fk fk fk fk fk fk fk kfkfkfk kfkfkfa ett and this is what im about",
      blogContent: [],
      path: "post-2");

  //final IconData? iconData;
  final String title;
  final String? imagePath;
  final String? blogDescription;
  final List<Widget?>? blogContent;
  final String path;

  const BlogPosts(
      {
      // this.iconData,
      required this.title,
      this.imagePath,
      this.blogDescription,
      this.blogContent,
      required this.path});
}

// extension DrawingModeExtension on String {
//   toDrawingModeEnum() =>
//       DrawingMode.values.firstWhere((e) => e.toString() == 'DrawingMode.$this');
// }

// extension DrawingModeX on DrawingMode {
//   toRegularString() => toString().split('.')[1];
// }

// enum BrushType {
//   none,
//   splatter;
// }
