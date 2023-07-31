// import 'package:flutter/material.dart';

// import '../../utils/utils.dart';
// import 'blog_page_desktop.dart';
// import 'blog_page_mobile.dart';

// class BlogPageLayout extends StatelessWidget {
//   const BlogPageLayout({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         Size size = MediaQuery.of(context).size;
//         if (size.width < mobileBreakpoint) {
//           return const BlogPageMobile();
//         } else {
//           return const BlogPageDesktop();
//         }
//       },
//     );
//   }
// }