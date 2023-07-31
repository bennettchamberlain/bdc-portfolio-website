import 'package:flutter/material.dart';

import '../../utils/utils.dart';
import 'contact_page_desktop.dart';
import 'contact_page_mobile.dart';

class ContactPageLayout extends StatelessWidget {
  const ContactPageLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        Size size = MediaQuery.of(context).size;
        if (size.width < mobileBreakpoint) {
          return const ContactPageMobile();
        } else {
          return const ContactPageDesktop();
        }
      },
    );
  }
}
