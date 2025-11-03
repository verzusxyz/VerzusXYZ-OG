import 'package:intl/intl.dart';

/// A utility class for handling date and time conversions.
class DateConverter {
  /// Formats a [DateTime] object into a string with the format 'yyyy-MM-dd hh:mm:ss'.
  ///
  /// - [dateTime]: The [DateTime] object to format.
  /// - Returns a formatted date string.
  static String formatDate(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd hh:mm:ss').format(dateTime);
  }

  /// Formats a date string into a more readable format 'dd MMM yyyy'.
  ///
  /// - [dateString]: The date string to format, expected in 'yyyy-MM-dd hh:mm:ss' format.
  /// - Returns a formatted date string.
  static String formatValidityDate(String dateString) {
    var inputDate = DateFormat('yyyy-MM-dd hh:mm:ss').parse(dateString);
    var outputFormat = DateFormat('dd MMM yyyy').format(inputDate);
    return outputFormat;
  }

  /// Converts an ISO 8601 date string to a local date and time string.
  ///
  /// - [dateTime]: The ISO 8601 date string.
  /// - [errorResult]: The string to return if the conversion fails.
  /// - Returns a formatted local date and time string (e.g., '25 Dec 2023, 10:30 AM'), or [errorResult] on failure.
  static String isoToLocalDateAndTime(String dateTime,
      {String errorResult = '--'}) {
    String date = '';
    if (dateTime.isEmpty || dateTime == 'null') {
      date = '';
    }
    try {
      date = DateFormat('dd MMM yyyy').format(isoStringToLocalDate(dateTime));
    } catch (v) {
      date = '';
    }
    String time = isoStringToLocalTimeOnly(dateTime);
    return '$date, $time';
  }

  /// Formats a [DateTime] object into a string with the format 'dd MMM yyyy - hh:mm:ss a'.
  ///
  /// - [dateTime]: The [DateTime] object to format.
  /// - Returns a formatted date and time string.
  static String estimatedDateTime(DateTime dateTime) {
    return DateFormat('dd MMM yyyy - hh:mm:ss a').format(dateTime);
  }

  /// Formats a [DateTime] object into a string with the format 'hh:mm:ss a'.
  ///
  /// - [dateTime]: The [DateTime] object to format.
  /// - Returns a formatted time string.
  static String estimatedTime(DateTime dateTime) {
    return DateFormat('hh:mm:ss a').format(dateTime);
  }

  /// Formats a deposit time string into 'yyyy-MM-dd' format.
  ///
  /// - [dateString]: The date string to format.
  /// - Returns a formatted date string.
  static String formatDepositTimeWithAmFormat(String dateString) {
    var newStr = '${dateString.substring(0, 10)} ${dateString.substring(11, 23)}';
    DateTime dt = DateTime.parse(newStr);
    String formatedDate = DateFormat("yyyy-MM-dd").format(dt);
    return formatedDate;
  }

  /// Formats a [DateTime] object into a string with the format 'dd MMM yyyy'.
  ///
  /// - [dateTime]: The [DateTime] object to format.
  /// - Returns a formatted date string.
  static String estimatedDate(DateTime dateTime) {
    return DateFormat('dd MMM yyyy').format(dateTime);
  }

  /// Converts a string in 'yyyy-MM-ddTHH:mm:ss.mmm' format to a [DateTime] object.
  ///
  /// - [dateTime]: The string to convert.
  /// - Returns a [DateTime] object.
  static DateTime convertStringToDatetime(String dateTime) {
    //return DateFormat("yyyy-MM-ddTHH:mm:ss.SSS").parse(dateTime);
    return DateFormat("yyyy-MM-ddTHH:mm:ss.mmm").parse(dateTime);
  }

  /// Converts an ISO 8601 string to a formatted string 'dd MMM yyyy hh:mm aa'.
  ///
  /// - [dateTime]: The ISO 8601 string to convert.
  /// - Returns a formatted date and time string.
  static String convertIsoToString(String dateTime) {
    DateTime time = convertStringToDatetime(dateTime);
    String result = DateFormat(
      'dd MMM yyyy hh:mm aa',
    ).format(time);
    return result;
  }

  /// Converts an ISO 8601 string to a local [DateTime] object.
  ///
  /// - [dateTime]: The ISO 8601 string to convert.
  /// - Returns a local [DateTime] object.
  static DateTime isoStringToLocalDate(String dateTime) {
    return DateFormat('yyyy-MM-ddTHH:mm:ss.SSS').parse(dateTime, true).toLocal();
  }

  /// Calculates the difference in days between a given ISO 8601 string and the current date.
  ///
  /// - [dateTime]: The ISO 8601 string.
  /// - Returns the difference in days as a string.
  static String isoToLocalTimeSubtract(String dateTime) {
    DateTime date = isoStringToLocalDate(dateTime);
    final currentDate = DateTime.now();
    final difference = currentDate.difference(date).inDays;
    return difference.toString();
  }

  /// Converts an ISO 8601 string to a local time string in 'hh:mm aa' format.
  ///
  /// - [dateTime]: The ISO 8601 string.
  /// - Returns a formatted local time string.
  static String isoStringToLocalTimeOnly(String dateTime) {
    return DateFormat('hh:mm aa').format(isoStringToLocalDate(dateTime));
  }

  /// Converts an ISO 8601 string to AM/PM.
  ///
  /// - [dateTime]: The ISO 8601 string.
  /// - Returns 'AM' or 'PM'.
  static String isoStringToLocalAMPM(String dateTime) {
    return DateFormat('a').format(isoStringToLocalDate(dateTime));
  }

  /// Converts an ISO 8601 string to a local date string in 'dd MMM yyyy' format.
  ///
  /// - [dateTime]: The ISO 8601 string.
  /// - Returns a formatted local date string, or '--' on failure.
  static String isoStringToLocalDateOnly(String dateTime) {
    try {
      return DateFormat('dd MMM yyyy').format(isoStringToLocalDate(dateTime));
    } catch (v) {
      return "--";
    }
  }

  /// Converts an ISO 8601 string to a local date string in 'dd MMM, yyyy' format.
  ///
  /// - [dateTime]: The ISO 8601 string.
  /// - Returns a formatted local date string, or '--' on failure.
  static String isoStringToLocalFormattedDateOnly(String dateTime) {
    try {
      return DateFormat('dd MMM, yyyy').format(isoStringToLocalDate(dateTime));
    } catch (v) {
      return "--";
    }
  }

  /// Formats a [DateTime] object to a string in 'dd-MM-yyyy' format.
  ///
  /// - [dateTime]: The [DateTime] object to format.
  /// - Returns a formatted date string.
  static String localDateTime(DateTime dateTime) {
    return DateFormat('dd-MM-yyyy').format(dateTime.toUtc());
  }

  /// Converts a local [DateTime] object to an ISO 8601 string.
  ///
  /// - [dateTime]: The [DateTime] object to convert.
  /// - Returns an ISO 8601 string.
  static String localDateToIsoString(DateTime dateTime) {
    return DateFormat('yyyy-MM-ddTHH:mm:ss.SSS').format(dateTime.toUtc());
  }

  /// Converts a time string from 'hh:mm:ss' to 'hh:mm a' format.
  ///
  /// - [time]: The time string to convert.
  /// - Returns a formatted time string.
  static String convertTimeToTime(String time) {
    return DateFormat('hh:mm a').format(DateFormat('hh:mm:ss').parse(time));
  }

  /// Formats a date string to 'dd MMM, yyyy hh:mm a' format.
  ///
  /// - [dateTime]: The date string to format.
  /// - Returns a formatted date and time string.
  static String nextReturnTime(String dateTime) {
    final date =
        DateFormat("dd MMM, yyyy hh:mm a").format(DateTime.parse(dateTime));
    return date;
  }

  /// Calculates and formats the time difference between a given time and now (e.g., '5 minutes ago').
  ///
  /// - [time]: The ISO 8601 string representing the time.
  /// - [numericDates]: Whether to use numeric dates (not currently implemented).
  /// - Returns a human-readable string representing the time difference.
  static String getFormatedSubtractTime(String time,
      {bool numericDates = false}) {
    final date1 = DateTime.now();
    final isoDate = isoStringToLocalDate(time);
    final difference = date1.difference(isoDate);

    if ((difference.inDays / 365).floor() >= 1) {
      int year = (difference.inDays / 365).floor();
      return '$year year ago';
    } else if ((difference.inDays / 30).floor() >= 1) {
      int month = (difference.inDays / 30).floor();
      return '$month month ago';
    } else if ((difference.inDays / 7).floor() >= 1) {
      int week = (difference.inDays / 7).floor();
      return '$week week ago';
    } else if (difference.inDays >= 1) {
      return '${difference.inDays} days ago';
    } else if (difference.inHours >= 1) {
      return '${difference.inHours} hours ago';
    } else if (difference.inMinutes >= 1) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inSeconds >= 3) {
      return '${difference.inSeconds} seconds ago';
    } else {
      return 'Just now';
    }
  }
}
