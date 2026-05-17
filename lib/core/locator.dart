import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

import 'logger.dart';

final GetIt locator = GetIt.instance;

class LocatorInjector {
  static Future<void> setUpLocator() async {
    final Logger log = getLogger('Locator Injector');
    log.d('Locator setup complete');
  }
}
