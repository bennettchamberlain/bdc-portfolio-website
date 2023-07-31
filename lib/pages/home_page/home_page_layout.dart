import 'package:flutter/material.dart';
import '../../utils/utils.dart';
import 'home_page_desktop.dart';
import 'home_page_mobile.dart';


class HomePageLayout extends StatelessWidget {
  const HomePageLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        Size size = MediaQuery.of(context).size;
        if (size.width < mobileBreakpoint) {
          return const HomePageMobile();
        } else {
          return const HomePageDesktop();
        }
      },
    );
  }
}