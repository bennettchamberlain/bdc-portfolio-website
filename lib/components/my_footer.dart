import '../components/button_box.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MyFooter extends StatelessWidget {
  final bool mobile;
  const MyFooter({required this.mobile, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          flex: 2,
          child: ButtonBox(
              mobile: mobile,
              width: 150,
              height: 50,
              border: false,
              text: "Home",
              fontSize: mobile ? 14 : 20,
              alignCorL: true,
              onPressed: () {
                if (GoRouterState.of(context).uri.path != "/") {
                  FirebaseAnalytics.instance
                      .logEvent(name: 'home_page_navigation');
                }
                context.go("/");
              }),
        ),
        mobile
            ? Container()
            : const SizedBox(
                width: 15,
              ),
        Flexible(
          flex: 2,
          child: ButtonBox(
              mobile: mobile,
              width: 150,
              height: 50,
              border: false,
              text: "About",
              fontSize: mobile ? 14 : 20,
              alignCorL: true,
              onPressed: () {
                if (GoRouterState.of(context).uri.path != "/about") {
                    FirebaseAnalytics.instance
                        .logEvent(name: 'about_page_navigation');
                }
                context.go("/about");
              }),
        ),
        mobile
            ? Container()
            : const SizedBox(
                width: 15,
              ),
        Flexible(
          flex: 2,
          child: ButtonBox(
              mobile: mobile,
              width: 150,
              height: 50,
              border: false,
              text: "Projects",
              fontSize: mobile ? 14 : 20,
              alignCorL: true,
              onPressed: () {
                if (GoRouterState.of(context).uri.path != "/content/projects") {
                  FirebaseAnalytics.instance
                      .logEvent(name: 'projects_page_navigation');
                }
                context.go("/content/projects");
              }),
        ),
        mobile
            ? Container()
            : const SizedBox(
                width: 15,
              ),
        Flexible(
          flex: 2,
          child: ButtonBox(
              mobile: mobile,
              width: 150,
              height: 50,
              border: false,
              text: "Blog",
              fontSize: mobile ? 14 : 20,
              alignCorL: true,
              onPressed: () {
                if (GoRouterState.of(context).uri.path != "/content/blogs") {
                  FirebaseAnalytics.instance
                      .logEvent(name: 'blog_page_navigation');
                }
                context.go("/content/blogs");
              }),
        ),
        mobile
            ? Container()
            : const SizedBox(
                width: 15,
              ),
        Flexible(
          flex: 2,
          child: ButtonBox(
              mobile: mobile,
              width: 150,
              height: 50,
              border: false,
              text: "Contact",
              fontSize: mobile ? 14 : 20,
              alignCorL: true,
              onPressed: () {
                if (GoRouterState.of(context).uri.path != "/contact") {
                  FirebaseAnalytics.instance
                      .logEvent(name: 'contact_page_navigation');
                }
                context.go("/contact");
              }),
        ),
      ],
    );
  }
}
