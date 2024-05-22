import 'dart:convert';

import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';

import 'env.dart';

class Utils {
  Utils._();

  static void log(param, [String? log]) {
    try {
      final msg = param is String ? param : json.encode(param);
      debugPrint('${log ?? ''} $msg');
    } catch (e) {
      debugPrint('[ERROR]: $e');
    }
  }

  static Flavor? get getFlavor => EnumToString.fromString(Flavor.values, const String.fromEnvironment('FLAVOR')); // check --dart-define=FLAVOR=development in makefile

  // static void showToast(String? msg) {
  //   // if (msg == null) return;
  //   EasyLoading.showToast('$msg', dismissOnTap: true);
  // }

  // static void showLoading({String? msg}) {
  //   // msg ??= S.current.loading;
  //   EasyLoading.show(dismissOnTap: true);
  // }

  // static void hideLoading() {
  //   EasyLoading.dismiss();
  // }

  // static void configLoading() {
  //   EasyLoading.instance
  //     ..displayDuration = const Duration(milliseconds: 2000)
  //     ..loadingStyle = EasyLoadingStyle.dark
  //     ..maskType = EasyLoadingMaskType.black
  //     ..indicatorType = EasyLoadingIndicatorType.ring
  //     ..toastPosition = EasyLoadingToastPosition.bottom
  //     ..indicatorSize = 30
  //     ..lineWidth = 3.0;
  // }
}
