import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

import '../../components/my_footer.dart';
import '../../components/my_marquee.dart';
import '../../components/my_navigation_bar.dart';

class HomePageDesktop extends StatefulWidget {
  const HomePageDesktop({super.key});

  @override
  State<HomePageDesktop> createState() => _HomePageDesktopState();
}

class _HomePageDesktopState extends State<HomePageDesktop>
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
    Size size = MediaQuery.of(context).size;
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
                          height: 110,
                        ),
                        //PUT EVERYTIHING HERE
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 450,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 8, color: Colors.black)),
                              child: Image.asset("assets/images/headshot.jpg"),
                            ),
                            const SizedBox(width: 15),
                            AnimatedContainer(
                              curve: Curves.fastOutSlowIn,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 8, color: Colors.black)),
                              duration: const Duration(milliseconds: 1600),
                              height: selectedNavigation ? 505 : 0,
                              width: size.width - 495,
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: SizedBox(
                                    width: 500,
                                    child: AnimatedTextKit(
                                      totalRepeatCount: 1,
                                      animatedTexts: [
                                        TyperAnimatedText(
                                            "Software Engineer\nProject Manager\nLifelong Student",
                                            speed: const Duration(
                                              milliseconds: 100,
                                            ),
                                            textStyle: const TextStyle(
                                                fontFamily: "Helvetica-Bold",
                                                fontSize: 50))
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),

                        const SizedBox(height: 25),
                        MyFooter(mobile: false),
                      ],
                    ),
                    const MyNavigationBar(mobile: false),
                  ],
                ),
              ),
              const MyMarquee(
                  mobile: false,
                  text:
                      " Pixel perfect designs. Cross-platform applications. Full-stack websites. "),
            ],
          ),
        ),
      ),
    );
  }
}
