import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension DateTimeFormatting on DateTime {
  String get dayLabel => DateFormat('EEE, MMM d').format(this);

  String get timeLabel => DateFormat.jm().format(this);

  String formattedString() {
    if (hour == 0 && minute == 0) return dayLabel;

    return '$dayLabel, $timeLabel';
  }

  TimeOfDay? getNullableTime() {
    if (hour == 0 && minute == 0) return null;

    return TimeOfDay.fromDateTime(this);
  }
}
