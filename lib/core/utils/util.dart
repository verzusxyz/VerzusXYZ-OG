import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:verzusxyz/core/utils/my_color.dart';

import 'my_strings.dart';

/// A utility class with miscellaneous helper methods.
class MyUtils {
  /// Sets the system UI overlay style for the splash screen.
  static splashScreen() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: MyColor.topColor,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: MyColor.topColor,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
  }

  /// Sets the system UI overlay style for all screens.
  static allScreen() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: MyColor.topColor,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: MyColor.topColor,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
  }

  /// Returns a list of [BoxShadow] for a subtle shadow effect.
  static dynamic getShadow() {
    return [
      BoxShadow(
        blurRadius: 15.0,
        offset: const Offset(0, 25),
        color: Colors.grey.shade500.withOpacity(0.6),
        spreadRadius: -35.0,
      ),
    ];
  }

  /// Returns the required sign character.
  static String getRequiredSign() {
    return "*";
  }

  /// Returns the percent sign character.
  static String getPercentSign() {
    return "%";
  }

  /// Returns the multiplication sign character.
  static String getIntoSign() {
    return "X ";
  }

  /// Returns a list of [BoxShadow] for a bottom sheet shadow effect.
  static dynamic getBottomSheetShadow() {
    return [
      BoxShadow(
        color: Colors.grey.shade400.withOpacity(0.08),
        spreadRadius: 3,
        blurRadius: 4,
        offset: const Offset(0, 3),
      ),
    ];
  }

  /// Returns a list of [BoxShadow] for a card shadow effect.
  static dynamic getCardShadow() {
    return [
      BoxShadow(
        color: Colors.grey.shade400.withOpacity(0.05),
        spreadRadius: 2,
        blurRadius: 2,
        offset: const Offset(0, 3),
      ),
    ];
  }

  /// Formats a string to be used as an operation title.
  ///
  /// - [value]: The string to format.
  /// - Returns a formatted title string.
  static getOperationTitle(String value) {
    String number = value;
    RegExp regExp = RegExp(r'^(\d+)(\w+)$');
    Match? match = regExp.firstMatch(number);
    if (match != null) {
      String? num = match.group(1) ?? '';
      String? unit = match.group(2) ?? '';
      String title = '${MyStrings.last.tr} $num ${unit.capitalizeFirst}';
      return title.tr;
    } else {
      return value.tr;
    }
  }
}
