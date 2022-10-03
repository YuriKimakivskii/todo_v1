import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateAndTime {
  static DateTime selectedDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  static String today =
      DateFormat('dd MMMM, yyyy', 'uk').format(DateTime.now());

  static String getFromatTime(TimeOfDay time) {
    String result = '';
    int hour = time.hour;
    int minute = time.minute;
    if (hour < 10) {
      result = '0$hour:';
    } else if (hour == 0) {
      result = '00:';
    } else {
      result = '$hour:';
    }
    if (minute < 10) {
      result += '0$minute';
    } else if (minute == 0) {
      result += '00';
    } else {
      result += '$minute';
    }
    return result;
  }
}
