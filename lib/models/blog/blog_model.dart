import 'package:bdc_website_v2/core/models/image_element.dart';
import 'package:bdc_website_v2/core/models/text_element.dart';
import 'package:bdc_website_v2/core/models/ui_element.dart';

class Blog {
  String authorName;
  String desc;
  String id;
  String title;
  List<TextWidget>? textElements = [];
  List<ImageWidget>? imageElements = [];
  String imgUrl;
  Blog(
      {required this.authorName,
      required this.id,
      required this.imgUrl,
      required this.desc,
      required this.title,
      this.imageElements,
      this.textElements});

  factory Blog.fromMap(Map<String, dynamic> json) {
    List<TextWidget> textWidgets = [];
    List<ImageWidget> imageWidgets = [];
    for (int x = 0; x < json['text'].length; x++) {
      textWidgets.add(TextWidget.fromJson(json['text'][x]));
    }
    for (int x = 0; x < json['image'].length; x++) {
      imageWidgets.add(ImageWidget.fromJson(json['image'][x]));
    }

    return Blog(
        authorName: json["author"],
        desc: json["desc"],
        title: json["title"],
        id: json["id"],
        imgUrl: json['imgUrl'],
        imageElements: imageWidgets,
        textElements: textWidgets);
  }

  List<UIComponent> getAllUIElements() {
    List<UIComponent> elements = [...?textElements, ...?imageElements];
    elements.sort((a, b) => a.getPriority().compareTo(b.getPriority()));

    return elements;
  }
}
