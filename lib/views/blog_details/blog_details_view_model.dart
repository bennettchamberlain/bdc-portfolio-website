import 'package:bdc_website_v2/core/models/image_element.dart';
import 'package:bdc_website_v2/core/models/ui_element.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:bdc_website_v2/core/logger.dart';
import 'package:vrouter/vrouter.dart';

import '../../core/models/text_element.dart';
import '../../models/blog/blog_model.dart';

class BlogDetailsViewModel extends BaseViewModel {
  late Logger log;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late String id;
  late String type;
  late Blog selectedBlog;

  // void sortWidgets() {
  // elements.sort((a, b) => a.getPriority().compareTo(b.getPriority()));
  // }

  String adUnitCode =
      """<script async src="https://pagead2.googlesyndication.com/pagead/js/adsbygoogle.js?client=ca-pub-9154794803302860"
     crossorigin="anonymous"></script>
<!-- adunit1 -->
<ins class="adsbygoogle"
     style="display:block"
     data-ad-client="ca-pub-9154794803302860"
     data-ad-slot="8006810190"
     data-ad-format="auto"
     data-full-width-responsive="true"></ins>
<script>
     (adsbygoogle = window.adsbygoogle || []).push({});
</script>""";

  BlogDetailsViewModel(context) {
    log = getLogger(runtimeType.toString());
    id = VRouter.of(context).pathParameters['Id']!;
    type = VRouter.of(context).pathParameters['type']!;
    // sortWidgets();
  }

  Future<Blog> getBlog() async {
    final data = await firestore.collection(type).doc(id).get();
    return Blog.fromMap(data.data()!);
  }
}
