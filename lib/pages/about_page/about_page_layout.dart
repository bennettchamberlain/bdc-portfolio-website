import 'package:flutter/material.dart';

import '../../utils/utils.dart';
import 'about_page_desktop.dart';

class AboutPageLayout extends StatelessWidget {
  const AboutPageLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        Size size = MediaQuery.of(context).size;
        if (size.width < mobileBreakpoint) {
          return const AboutPageMobile();
        } else {
          return const AboutPageDesktop();
        }
      },
    );
  }
}