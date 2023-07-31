import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:bdc_website_v2/core/logger.dart';

class ContactViewModel extends BaseViewModel {
  late Logger log;

  ContactViewModel() {
    log = getLogger(runtimeType.toString());
  }

    bool selectedNavigation = false;
}
