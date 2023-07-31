// import 'package:bdc_website_v2/pages/project_page/project_page_mobile.dart';
// import 'package:flutter/material.dart';

// import '../../utils/utils.dart';
// import 'project_page_desktop.dart';

// class ProjectsPageLayout extends StatelessWidget {
//   const ProjectsPageLayout({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         Size size = MediaQuery.of(context).size;
//         if (size.width < mobileBreakpoint) {
//           return const ProjectsPageMobile();
//         } else {
//           return const ProjectsPageDesktop();
//         }
//       },
//     );
//   }
// }