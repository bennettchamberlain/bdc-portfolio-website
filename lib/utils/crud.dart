import 'package:cloud_firestore/cloud_firestore.dart';

class CrudMethods {
  Future<void> addData(blogData) async {
    FirebaseFirestore.instance
        .collection('blogs')
        .add(blogData)
        .catchError((e) {
      print(e);
      return e;
    });
  }

  getBlogsData() async {
    return await FirebaseFirestore.instance
        .collection('blogs')
        .get()
        .then((QuerySnapshot result) {
      //blogsSnapshot = result;
      print(result);
    });
  }

  getResumeData() async {
    return await FirebaseFirestore.instance
        .collection('resume')
        .get()
        .then((QuerySnapshot result) {
      print(result);
      return result;
    });
  }
}
