import 'dart:math';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vrouter/vrouter.dart';

import '../models/blog/blog_model.dart';

class BlogCard extends StatelessWidget {
  // final String title;
  // final String? imagePath;
  // final String? blogDescription;
  // final List<Widget?> blogContent;
  // final String path;
  final bool? mobile;
  final String? id;
  final String type;
  final Blog? blog;

  const BlogCard(
      {this.id, this.mobile, this.blog, required this.type, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 8, color: Colors.black),
            right: BorderSide(width: 0, color: Colors.black),
          ),
        ),
        child: InkWell(
          splashColor: Color((Random().nextDouble() * 0xFFFFFF).toInt())
              .withOpacity(1.0),
          onTap: () {
            final box = GetStorage();
            box.write('selectedBlog', blog);
            context.vRouter.to(
              "/content/$type/$id",
            );
            // Navigate to the larger page.
            // if (context.vRouter.path != path) {
            //   FirebaseAnalytics.instance.logEvent(name: '$path-event');
            // }
            // context.vRouter.to(path);
          },
          child: Row(
            children: [
              Image.network(
                blog!.imgUrl ?? "assets/images/headshot.jpg",
                width: mobile! ? 150 : 200,
                height: mobile! ? 150 : 200,
                fit: BoxFit.cover,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    constraints: BoxConstraints(
                        maxWidth: mobile!
                            ? MediaQuery.of(context).size.width - 264
                            : MediaQuery.of(context).size.width - 190),
                    padding: const EdgeInsets.all(15),
                    child: Text(
                      blog!.title,
                      overflow: TextOverflow.visible,
                      style: TextStyle(fontSize: mobile! ? 30 : 45),
                    ),
                  ),
                  Container(
                    constraints: BoxConstraints(
                        maxWidth: mobile!
                            ? MediaQuery.of(context).size.width - 264
                            : MediaQuery.of(context).size.width - 190),
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      maxLines: 15,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      blog!.desc ?? "Empty Description",
                      style: mobile!
                          ? TextStyle(fontSize: 18)
                          : TextStyle(fontSize: 25),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ]);
  }
}
