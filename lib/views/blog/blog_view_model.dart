import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:bdc_website_v2/core/logger.dart';
import 'package:vrouter/vrouter.dart';

import '../../models/blog/blog_model.dart';

class BlogViewModel extends BaseViewModel {
  late Logger log;
  late String type;

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late Future<List<Blog>> blogs;
  BlogViewModel(context) {
    log = getLogger(runtimeType.toString());
    type = VRouter.of(context).pathParameters['type']!;
    blogs = getAllBlogs();
  }

  bool selectedNavigation = false;

  Future<List<Blog>> getAllBlogs() async {
    final list = await firestore.collection(type).get();
    return list.docs.map((e) => Blog.fromMap(e.data())).toList();
  }
}
