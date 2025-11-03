import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../utils/my_strings.dart';

/// A utility class for string and number conversions.
class Converter {
  /// Converts a string to capitalized case.
  ///
  /// - [value]: The string to convert.
  /// - Returns the capitalized string.
  static String toCapitalized(String value) {
    return value.toLowerCase().capitalizeFirst ?? '';
  }

  /// Rounds a double string to two decimal places and removes trailing zeros.
  ///
  /// - [value]: The double string to format.
  /// - Returns the formatted string.
  static String roundDoubleAndRemoveTrailingZero(String value) {
    try {
      double number = double.parse(value);
      String b = number.toStringAsFixed(2).replaceFirst(RegExp(r'\.?0*$'), '');
      return b;
    } catch (e) {
      return value;
    }
  }

  /// Formats a number string to a specified precision.
  ///
  /// - [value]: The number string to format.
  /// - [precision]: The number of decimal places.
  /// - Returns the formatted number string.
  static String formatNumber(String value, {int precision = 2}) {
    try {
      double number = double.parse(value);
      String b = number.toStringAsFixed(precision);
      return b;
    } catch (e) {
      return value;
    }
  }

  /// Removes quotation marks and square brackets from a string.
  ///
  /// - [value]: The string to format.
  /// - Returns the formatted string.
  static String removeQuotationAndSpecialCharacterFromString(String value) {
    try {
      String formatedString =
          value.replaceAll('"', '').replaceAll('[', '').replaceAll(']', '');
      return formatedString;
    } catch (e) {
      return value;
    }
  }

  /// Replaces underscores with spaces and capitalizes each word.
  ///
  /// - [value]: The string to format.
  /// - Returns the formatted string.
  static String replaceUnderscoreWithSpace(String value) {
    try {
      String formatedString = value.replaceAll('_', ' ');
      String v =
          formatedString.split(" ").map((str) => str.capitalize).join(" ");
      return v;
    } catch (e) {
      return value;
    }
  }

  /// Formats a date string to a human-readable format with a status (e.g., "5 minutes ago").
  ///
  /// - [inputValue]: The date string to format.
  /// - Returns the formatted date string.
  static String getFormatedDateWithStatus(String inputValue) {
    String value = inputValue;
    try {
      var list = inputValue.split(' ');
      var dateSection = list[0].split('-');
      var timeSection = list[1].split(':');
      int year = int.parse(dateSection[0]);
      int month = int.parse(dateSection[1]);
      int day = int.parse(dateSection[2]);
      int hour = int.parse(timeSection[0]);
      int minute = int.parse(timeSection[1]);
      int second = int.parse(timeSection[2]);
      final startTime = DateTime(year, month, day, hour, minute, second);
      final currentTime = DateTime.now();

      int dayDef = currentTime.difference(startTime).inDays;
      int hourDef = currentTime.difference(startTime).inHours;
      final minDef = currentTime.difference(startTime).inMinutes;
      final secondDef = currentTime.difference(startTime).inSeconds;

      if (dayDef == 0) {
        if (hourDef <= 0) {
          if (minDef <= 0) {
            value = '$secondDef ${MyStrings.secondAgo}'.tr;
          } else {
            value = '$hourDef ${MyStrings.minutesAgo}'.tr;
          }
        } else {
          value = '$hourDef ${MyStrings.hourAgo}'.tr;
        }
      } else {
        value = '$dayDef ${MyStrings.daysAgo}'.tr;
      }
    } catch (e) {
      value = inputValue;
    }

    return value;
  }

  /// Adds a trailing extension to a number (e.g., 1st, 2nd, 3rd).
  ///
  /// - [number]: The number to add the extension to.
  /// - Returns the number with the trailing extension.
  static String getTrailingExtension(int number) {
    List<String> list = [
      'th',
      'st',
      'nd',
      'rd',
      'th',
      'th',
      'th',
      'th',
      'th',
      'th'
    ];
    if (((number % 100) >= 11) && ((number % 100) <= 13)) {
      return '${number}th';
    } else {
      int value = (number % 10).toInt();
      return '$number${list[value]}';
    }
  }

  /// Adds a leading zero to a string if it's a single digit.
  ///
  /// - [value]: The string to format.
  /// - Returns the formatted string with a leading zero if needed.
  static String addLeadingZero(String value) {
    return value.padLeft(2, '0');
  }

  /// Calculates the sum of two number strings.
  ///
  /// - [first]: The first number string.
  /// - [last]: The second number string.
  /// - [precision]: The number of decimal places for the result.
  /// - Returns the sum as a formatted string.
  static String sum(String first, String last, {int precision = 2}) {
    double firstNum = double.tryParse(first) ?? 0;
    double secondNum = double.tryParse(last) ?? 0;
    double result = firstNum + secondNum;
    String formatedResult =
        formatNumber(result.toString(), precision: precision);
    return formatedResult;
  }

  /// Formats a percentage string with a currency symbol.
  ///
  /// - [curSymbol]: The currency symbol.
  /// - [s]: The percentage value string.
  /// - Returns the formatted percentage string, or an empty string if the value is not positive.
  static String showPercent(String curSymbol, String s) {
    double value = 0;
    value = double.tryParse(s) ?? 0;
    if (value > 0) {
      return ' + $curSymbol$value';
    } else {
      return '';
    }
  }

  /// Multiplies two number strings.
  ///
  /// - [first]: The first number string.
  /// - [second]: The second number string.
  /// - Returns the product as a formatted string.
  static mul(String first, String second) {
    double result =
        (double.tryParse(first) ?? 0) * (double.tryParse(second) ?? 0);
    return Converter.formatNumber(result.toString());
  }

  /// Calculates the rate by dividing an amount by a rate.
  ///
  /// - [amount]: The amount string.
  /// - [rate]: The rate string.
  /// - [precision]: The number of decimal places for the result.
  /// - Returns the calculated rate as a formatted string.
  static calculateRate(String amount, String rate, {int precision = 2}) {
    double result =
        (double.tryParse(amount) ?? 0) / (double.tryParse(rate) ?? 0);
    return Converter.formatNumber(result.toString(), precision: precision);
  }

  /// Extracts the text after the first equals sign in a string.
  ///
  /// - [input]: The input string.
  /// - Returns the text after the equals sign, or an empty string if not found.
  String getTextAfterEquals(String input) {
    var splitResult = input.split('=');

    if (splitResult.length > 1) {
      return splitResult[1].trim();
    }

    return '';
  }
}

/// An extension on the [String] class for casing operations.
extension StringCasingExtension on String {
  /// Converts the string to capitalized case.
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';

  /// Converts the string to title case.
  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}

/// Prints an object to the console in debug mode.
///
/// - [object]: The object to print.
void printx(Object? object) {
  if (kDebugMode) {
    print(object);
  }
}
