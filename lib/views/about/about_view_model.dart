import 'package:bdc_website_v2/models/about_us/resume_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:bdc_website_v2/core/logger.dart';

class AboutViewModel extends BaseViewModel {
  late Logger log;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  AboutViewModel() {
    log = getLogger(runtimeType.toString());
  }
  bool selectedNavigation = false;
  bool pageAnimation = false;

  Future<Resume?> getResumeUrl() async {
    final querySnapshot = await firestore.collection('resume').limit(1).get();
    return Resume.fromMap(querySnapshot.docs[0].data());
  }
}
