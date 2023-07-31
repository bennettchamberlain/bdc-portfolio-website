import 'package:flutter/material.dart';

enum ProjectPosts {
  ProjectPost1(
      title: "Event Ticketing Web App",
      imagePath: "assets/images/tickets-still-1.png",
      blogDescription:
          "This web app was built for the Mr. Brainwash Art Museum in Beverly Hills. This website was for close friends, press, influencers, and Hotel Guests of several Beverly Hills Hotels to get free tickets to the museum. This app sent an automated email containing a QR code ticket which was able to be scanned at the front door of the museum for entry.",
      blogContent: [
        SizedBox(height: 110),
      ],
      path: 'project-1',
      delay: Duration(milliseconds: 500)),
  ProjectPost2(
      title: "Street Art iPad App",
      imagePath: "assets/images/paintapp-still-1.png",
      blogDescription:
          "The Mr. Brainwash Paints app was a passion project and a toy for Mr. Brainwash. This tool is like an easy-to-use photoshop pre-loaded with all of his assets. Users are able to transform layers of art preloaded by the app or insert their own. Paintfrushes of all types including splatter paint burshes and stencils make the possibilities for creative expresion truly infinite.",
      blogContent: [],
      path: "project-2",
      delay: Duration(milliseconds: 1000));

  //final IconData? iconData;
  //final IconData? iconData;
  final String title;
  final String? imagePath;
  final String? blogDescription;
  final List<Widget>? blogContent;
  final String path;
  final Duration delay;

  const ProjectPosts(
      {
      // this.iconData,
      required this.title,
      this.imagePath,
      this.blogDescription,
      this.blogContent,
      required this.path,
      required this.delay});
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
