
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../utils/providers.dart';
import 'button_box.dart';

class MyNavigationBar extends StatefulWidget {
  final bool mobile;
  const MyNavigationBar({required this.mobile, super.key});

  @override
  State<MyNavigationBar> createState() => _MyNavigationBarState();
}

class _MyNavigationBarState extends State<MyNavigationBar> {
  bool selectedNavigation = false;

  @override
  void initState() {
    isSideMenuClosed.value = true;
    Future.delayed(const Duration(seconds: 0)).then((value) => setState(() {
          selectedNavigation = true;
        }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          children: [
            Container(
              decoration: BoxDecoration(
                  border: Border.all(width: 8, color: Colors.black)),
              child: AnimatedContainer(
                width: widget.mobile
                    ? (selectedNavigation
                        ? MediaQuery.of(context).size.width - 99
                        : 0)
                    : (selectedNavigation
                        ? MediaQuery.of(context).size.width - 136
                        : 0),
                duration: const Duration(milliseconds: 1600),
                curve: Curves.fastOutSlowIn,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 5.0, bottom: 8, left: 10, right: 10),
                    child: Text(
                      "BENNETT CHAMBERLAIN",
                      style: TextStyle(
                          fontFamily: "Primetime",
                          fontWeight: FontWeight.bold,
                          fontSize: widget.mobile ? 18 : 45),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              height: widget.mobile ? 53 : 90,
              width: widget.mobile ? 53 : 90,
              //padding: EdgeInsets.all(19),
              decoration: const BoxDecoration(
                  border: Border(
                      top: BorderSide(width: 8, color: Colors.black),
                      right: BorderSide(width: 8, color: Colors.black),
                      bottom: BorderSide(width: 8, color: Colors.black))),
              child: TextButton(
                style: const ButtonStyle(
                  splashFactory: InkRipple.splashFactory,
                ),
                onPressed: () {
                  Future.delayed(const Duration(seconds: 0))
                      .then((value) => setState(() {
                            isSideMenuClosed.value = !isSideMenuClosed.value;
                          }));
                },
                child: isSideMenuClosed.value
                    ? Icon(
                        Icons.menu,
                        size: widget.mobile ? 25 : 55,
                        color: Colors.black,
                      )
                    : Icon(
                        Icons.arrow_downward,
                        size: widget.mobile ? 25 : 55,
                        color: Colors.black,
                      ),
              ),
            ),
          ],
        ),
        AnimatedContainer(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              left: isSideMenuClosed.value
                  ? const BorderSide(width: 0, color: Colors.white)
                  : const BorderSide(width: 8, color: Colors.black),
              right: isSideMenuClosed.value
                  ? const BorderSide(width: 0, color: Colors.white)
                  : const BorderSide(width: 8, color: Colors.black),
              bottom: isSideMenuClosed.value
                  ? const BorderSide(width: 0, color: Colors.white)
                  : const BorderSide(width: 8, color: Colors.black),
            ),
          ),
          width: 200,
          height: isSideMenuClosed.value ? 0 : 270,
          duration: const Duration(milliseconds: 800),
          curve: Curves.fastOutSlowIn,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Center(
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 5.0, bottom: 8, left: 10, right: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ButtonBox(
                        mobile: widget.mobile,
                        width: widget.mobile ? 85 : 150,
                        height: 50,
                        border: false,
                        text: "Home",
                        fontSize: 20,
                        alignCorL: false,
                        onPressed: () {
                          if (GoRouterState.of(context).uri.path != "/") {
                            FirebaseAnalytics.instance
                                .logEvent(name: 'home_page_navigation');
                          }
                          context.go("/");
                        },
                      ),
                      ButtonBox(
                        mobile: widget.mobile,
                        width: widget.mobile ? 85 : 150,
                        height: 50,
                        border: false,
                        text: "About",
                        fontSize: 20,
                        alignCorL: false,
                        onPressed: () {
                          if (GoRouterState.of(context).uri.path != "/about") {
                            FirebaseAnalytics.instance
                                .logEvent(name: 'about_page_navigation');
                          }
                          context.go("/about");
                        },
                      ),
                      ButtonBox(
                        mobile: widget.mobile,
                        width: 150,
                        height: 50,
                        border: false,
                        text: "Projects",
                        fontSize: 20,
                        alignCorL: false,
                        onPressed: () {
                          if (GoRouterState.of(context).uri.path != "/content/projects") {
                            FirebaseAnalytics.instance
                                .logEvent(name: 'projects_page_navigation');
                          }
                          context.go("/content/projects");
                        },
                      ),
                      ButtonBox(
                        mobile: widget.mobile,
                        width: 150,
                        height: 50,
                        border: false,
                        text: "Blog",
                        fontSize: 20,
                        alignCorL: false,
                        onPressed: () {
                          if (GoRouterState.of(context).uri.path != "/content/blogs") {
                            FirebaseAnalytics.instance
                                .logEvent(name: "/content/blogs");
                          }
                          context.go("/content/blogs");
                        },
                      ),
                      ButtonBox(
                        mobile: widget.mobile,
                        width: 150,
                        height: 50,
                        border: false,
                        text: "Contact",
                        fontSize: 20,
                        alignCorL: false,
                        onPressed: () {
                          if (GoRouterState.of(context).uri.path != "/contact") {
                            FirebaseAnalytics.instance
                                .logEvent(name: 'contact_page_navigation');
                          }
                          context.go("/contact");
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
