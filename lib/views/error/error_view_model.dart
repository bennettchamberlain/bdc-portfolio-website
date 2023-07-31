import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:bdc_website_v2/core/logger.dart';

class ErrorViewModel extends BaseViewModel {
 late Logger log;

  ErrorViewModel() {
    log = getLogger(runtimeType.toString());
  }

    bool selectedNavigation = false;
}
