import 'package:flutter/material.dart';

import '../../components/my_footer.dart';
import '../../components/my_navigation_bar.dart';

class AboutPageMobile extends StatefulWidget {
  const AboutPageMobile({super.key});

  @override
  State<AboutPageMobile> createState() => _AboutPageMobileState();
}

class _AboutPageMobileState extends State<AboutPageMobile> {
  bool selectedNavigation = false;
  bool pageAnimation = false;
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 0)).then((value) => setState(() {
          selectedNavigation = true;
        }));
    Future.delayed(const Duration(milliseconds: 600))
        .then((value) => setState(() {
              pageAnimation = true;
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
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Stack(
              children: [
                Column(
                  children: [
                    const SizedBox(
                      height: 65,
                    ),
                    Stack(
                      children: [
                        Container(
                          height: 500,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.black, width: 8)),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10),
                            AnimatedContainer(
                              curve: Curves.fastOutSlowIn,
                              decoration: const BoxDecoration(
                                border: Border(
                                  bottom:
                                      BorderSide(width: 8, color: Colors.black),
                                ),
                              ),
                              duration: const Duration(milliseconds: 1100),
                              height: pageAnimation ? 490 : 0,
                              width: size.width,
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: ConstrainedBox(
                                        constraints:
                                            const BoxConstraints(maxWidth: 500),
                                        child: const SelectableText(
                                            "Born: Denver, Colorado\nHome (For Now): Los Angeles\nPlaces I've Lived: New Jersey, Manhattan, San Francisco, Westchester New York, Blacksburg Virginia"),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: ConstrainedBox(
                                        constraints:
                                            const BoxConstraints(maxWidth: 600),
                                        child: const SelectableText(
                                            "Hobbies: \nBilliards Basketball Skiing Golf Tennis Weight lifting Surfing Poker Watches Guitar Yoga Volunteering Gardening Reading French Spanish Running Dancing Hiking/exploring Free-styling & Poetry "),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: ConstrainedBox(
                                        constraints:
                                            const BoxConstraints(maxWidth: 600),
                                        child: const SelectableText(
                                            "If you can't lose, then you can't win. \n\nFind what you love that fuels you vision. Iterate, improve, repeat and make time to enjoy life"),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    MyFooter(mobile: true)
                  ],
                ),
                //PUT EVERYTIHING HERE
                // Positioned(
                //   top: 600,
                //   width: size.width,
                //   child: MyFooter(
                //     mobile: false,
                //   ),
                // ),
                const MyNavigationBar(mobile: true),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
