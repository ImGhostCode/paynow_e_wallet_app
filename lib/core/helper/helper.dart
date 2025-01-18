import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:paynow_e_wallet_app/main.dart';
import 'package:paynow_e_wallet_app/shared/data/data_sources/app_shared_prefs.dart';
import 'package:paynow_e_wallet_app/shared/domain/entities/language_enum.dart';
import 'package:paynow_e_wallet_app/core/utils/constant/app_constants.dart';
import 'package:paynow_e_wallet_app/core/utils/injections.dart';

class Helper {
  /// Get language
  static LanguageEnum getLang() {
    LanguageEnum? lang;
    lang = sl<AppSharedPrefs>().getLang();
    lang = lang ?? LanguageEnum.en;
    return lang;
  }

  /// Get svg picture path
  static String getSvgPath(String name) {
    return "$svgPath$name";
  }

  /// Get image picture path
  static String getImagePath(String name) {
    return "$imagePath$name";
  }

  /// Get vertical space
  static double getVerticalSpace() {
    return 10.h;
  }

  /// Get horizontal space
  static double getHorizontalSpace() {
    return 10.w;
  }

  /// Get Dio Header
  static Map<String, dynamic> getHeaders() {
    return {}..removeWhere((key, value) => value == null);
  }

  static bool isDarkTheme() {
    return sl<AppSharedPrefs>().getIsDarkTheme();
  }

  static bool isTablet(BuildContext context) {
    return MediaQuery.of(context).size.shortestSide >= 600;
  }

  static void showSnackBar(
      {required String? message, bool? isSuccess = false}) {
    snackBarKey.currentState!.showSnackBar(
      SnackBar(
        content: Text(message ?? ''),
        duration: const Duration(seconds: 2),
        backgroundColor: isSuccess! ? Colors.green : Colors.red,
      ),
    );
  }

  static DateTime fromJsonTimestamp(Timestamp timestamp) {
    return timestamp.toDate();
  }
}
