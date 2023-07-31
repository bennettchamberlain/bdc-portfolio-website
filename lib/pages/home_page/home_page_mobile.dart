
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

import '../../components/my_footer.dart';
import '../../components/my_marquee.dart';
import '../../components/my_navigation_bar.dart';

class HomePageMobile extends StatefulWidget {
  const HomePageMobile({super.key});

  @override
  State<HomePageMobile> createState() => _HomePageMobileState();
}

class _HomePageMobileState extends State<HomePageMobile>
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
                        const SizedBox(height: 65),
                        //PUT EVERYTIHING HERE
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 8, color: Colors.black)),
                              child: Image.asset("assets/images/headshot.jpg"),
                            ),
                            const SizedBox(height: 15),
                            AnimatedContainer(
                              curve: Curves.fastOutSlowIn,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 8, color: Colors.black)),
                              duration: const Duration(milliseconds: 1600),
                              height: selectedNavigation ? 150 : 0,
                              width: size.width,
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
                                                fontSize: 20))
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),

                        const SizedBox(height: 25),
                        MyFooter(mobile: true),
                      ],
                    ),
                    const MyNavigationBar(mobile: true),
                  ],
                ),
              ),
              const MyMarquee(
                  mobile: true,
                  text:
                      " Pixel perfect designs. Cross-platform applications. Full-stack websites. "),
            ],
          ),
        ),
      ),
    );
  }
}
