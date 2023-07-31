
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

import '../../components/my_footer.dart';
import '../../components/my_navigation_bar.dart';

class WrongPageDesktop extends StatefulWidget {
  const WrongPageDesktop({super.key});

  @override
  State<WrongPageDesktop> createState() => _WrongPageDesktopState();
}

class _WrongPageDesktopState extends State<WrongPageDesktop>
    with SingleTickerProviderStateMixin {
  bool selectedNavigation = false;

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 0)).then((value) => setState(() {
          selectedNavigation = true;
        }));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      extendBody: true,
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Stack(
                  children: [
                    Column(
                      children: [
                        const SizedBox(
                          height: 150,
                        ),
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 1200),
                          child: const SelectableText(
                            "This page doesnt exist...Awkward",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 30,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height,
                          child: const RiveAnimation.asset(
                              '/animations/404.riv',
                              artboard: '404-error.svg',
                              fit: BoxFit.contain),
                        ),
                        const SizedBox(height: 50),
                        const SizedBox(height: 50),
                        MyFooter(mobile: false),
                      ],
                    ),
                    const MyNavigationBar(mobile: false),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
