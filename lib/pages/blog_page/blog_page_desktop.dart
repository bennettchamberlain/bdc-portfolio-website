// import 'package:flutter/material.dart';

// import '../../components/blog_card.dart';
// import '../../components/my_footer.dart';
// import '../../components/my_navigation_bar.dart';
// import 'blog_posts_enums.dart';

// class BlogPageDesktop extends StatefulWidget {
//   const BlogPageDesktop({super.key});

//   @override
//   State<BlogPageDesktop> createState() => _BlogPageDesktopState();
// }

// class _BlogPageDesktopState extends State<BlogPageDesktop>
//     with SingleTickerProviderStateMixin {
//   bool selectedNavigation = false;

//   @override
//   void initState() {
//     Future.delayed(const Duration(seconds: 0)).then((value) => setState(() {
//           selectedNavigation = true;
//         }));

//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     //Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       backgroundColor: Colors.white,
//       resizeToAvoidBottomInset: false,
//       extendBody: true,
//       body: Container(
//         color: Colors.white,
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(15.0),
//             child: Stack(
//               children: [
//                 Column(
//                   children: [
//                     const SizedBox(
//                       height: 110,
//                     ),

//                     //PUT EVERYTIHING HERE
//                     Container(
//                       decoration: BoxDecoration(border: Border.all(width: 8)),
//                       child: Padding(
//                         padding: const EdgeInsets.all(15),
//                         child: Container(
//                           child: Column(children: [
//                             ...BlogPosts.values.map(
//                               (e) => BlogCard(
//                                 id: "",
//                                 title: e.title,
//                                 blogDescription: e.blogDescription,
//                                 imagePath: e.imagePath,
//                                 blogContent: e.blogContent ?? [],
//                                 path: e.path,
//                                 mobile: false,
//                               ),
//                             )
//                           ]),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 50),
//                     MyFooter(mobile: false),
//                   ],
//                 ),
//                 const MyNavigationBar(mobile: false),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
