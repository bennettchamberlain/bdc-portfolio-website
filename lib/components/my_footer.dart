import '../components/button_box.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:vrouter/vrouter.dart';

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
                if (context.vRouter.path != "/") {
                  FirebaseAnalytics.instance
                      .logEvent(name: 'home_page_navigation');
                }
                context.vRouter.to("/");
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
                if (context.vRouter.path != "/about") {
                    FirebaseAnalytics.instance
                        .logEvent(name: 'about_page_navigation');
                }
                context.vRouter.to("/about");
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
                if (context.vRouter.path != "/projects") {
                  FirebaseAnalytics.instance
                      .logEvent(name: 'projects_page_navigation');
                }
                context.vRouter.to("/content/projects");
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
                if (context.vRouter.path != "/content") {
                  FirebaseAnalytics.instance
                      .logEvent(name: 'blog_page_navigation');
                }
                context.vRouter.to("/content/blogs");
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
                if (context.vRouter.path != "/contact") {
                  FirebaseAnalytics.instance
                      .logEvent(name: 'contact_page_navigation');
                }
                context.vRouter.to("/contact");
              }),
        ),
      ],
    );
  }
}
