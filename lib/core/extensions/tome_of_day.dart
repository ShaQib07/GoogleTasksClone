import 'package:flutter/material.dart';

extension TimeOfDayExtensions on TimeOfDay {
  String toSimpleString() {
    final h = hourOfPeriod == 0 ? 12 : hourOfPeriod; // 12-hour format
    final m = minute.toString().padLeft(2, '0');     // pad minutes
    final periodStr = period == DayPeriod.am ? 'AM' : 'PM';
    return '$h:$m $periodStr';
  }
}
