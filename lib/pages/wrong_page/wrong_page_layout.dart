import 'package:flutter/material.dart';

import '../../utils/utils.dart';
import 'wrong_page_desktop.dart';
import 'wrong_page_mobile.dart';

class WrongPageLayout extends StatelessWidget {
  const WrongPageLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        Size size = MediaQuery.of(context).size;
        if (size.width < mobileBreakpoint) {
          return const WrongPageMobile();
        } else {
          return const WrongPageDesktop();
        }
      },
    );
  }
}