import 'package:flutter/material.dart';
import 'package:flutter_ad_manager_web/flutter_ad_manager_web.dart';

Widget blogAdBanner({
  required String adUnitCode,
  double? width,
  double? height,
  bool debug = false,
}) =>
    FlutterAdManagerWeb(
      adUnitCode: adUnitCode,
      width: width,
      height: height,
      debug: debug,
    );
