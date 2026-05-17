import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_storage/get_storage.dart';
import 'app_router.dart';
import 'core/locator.dart';
import 'firebase_options.dart';

void main() async {
  await LocatorInjector.setUpLocator();
  await FastCachedImageConfig.init(clearCacheAfter: const Duration(days: 15));
  await GetStorage.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp.router(
        routerConfig: appRouter,
        debugShowCheckedModeBanner: false,
        title: 'BDC - KIP',
        theme: ThemeData(
          useMaterial3: false,
          fontFamily: 'Helvetica',
          primarySwatch: Colors.grey,
        ),
      ),
    );
  }
}
