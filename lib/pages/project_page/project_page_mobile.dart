
// import 'package:flutter/material.dart';

// import '../../components/blog_card.dart';
// import '../../components/my_navigation_bar.dart';
// import 'projects_enums.dart';

// class ProjectsPageMobile extends StatefulWidget {
//   const ProjectsPageMobile({super.key});

//   @override
//   State<ProjectsPageMobile> createState() => _ProjectsPageMobileState();
// }

// class _ProjectsPageMobileState extends State<ProjectsPageMobile> {
//   bool selectedNavigation = false;
//   List<bool> activatedPost = [
//     false,
//     false,
//     false,
//     false,
//     false,
//   ];
//   @override
//   void initState() {
//     Future.delayed(const Duration(milliseconds: 0))
//         .then((value) => setState(() {
//               selectedNavigation = true;
//             }));
//     Future.delayed(const Duration(milliseconds: 500))
//         .then((value) => setState(() {
//               activatedPost[0] = true;
//             }));
//     Future.delayed(const Duration(milliseconds: 1000))
//         .then((value) => setState(() {
//               activatedPost[1] = true;
//             }));
//     Future.delayed(const Duration(milliseconds: 1500))
//         .then((value) => setState(() {
//               activatedPost[2] = true;
//             }));
//     Future.delayed(const Duration(milliseconds: 2000))
//         .then((value) => setState(() {
//               activatedPost[3] = true;
//             }));
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       backgroundColor: Colors.white,
//       resizeToAvoidBottomInset: false,
//       extendBody: true,
//       body: SingleChildScrollView(
//         child: Stack(
//           children: [
//             Column(
//               children: [
//                 const SizedBox(height: 110),
//                 Padding(
//                   padding: const EdgeInsets.all(15.0),
//                   child: Container(
//                     height: 1200,
//                     decoration: BoxDecoration(
//                       border: Border.all(width: 8, color: Colors.black),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             Padding(
//               padding: const EdgeInsets.all(15),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const SizedBox(height: 110),
//                   ...ProjectPosts.values.map(
//                     (e) => AnimatedContainer(
//                       duration: const Duration(milliseconds: 600),
//                       width: activatedPost[e.index] ? size.width : 0,
//                       child: SingleChildScrollView(
//                         scrollDirection: Axis.horizontal,
//                         child: BlogCard(
//                           id: "",
//                           title: e.title,
//                           blogDescription: e.blogDescription,
//                           imagePath: e.imagePath,
//                           blogContent: e.blogContent ?? [],
//                           path: e.path,
//                           mobile: true,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const Padding(
//               padding: EdgeInsets.all(15.0),
//               child: MyNavigationBar(mobile: true),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }