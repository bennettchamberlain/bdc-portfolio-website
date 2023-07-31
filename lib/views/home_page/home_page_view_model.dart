import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:bdc_website_v2/core/logger.dart';

class HomePageViewModel extends BaseViewModel {
  late Logger log;

  HomePageViewModel() {
    log = getLogger(runtimeType.toString());
  }
    bool selectedNavigation = false;

}
