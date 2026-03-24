import 'package:flutter/material.dart';

import '../../../../../core/extensions/date_time.dart';

class TaskDateTime extends StatelessWidget {
  const TaskDateTime({super.key, required this.dateTime, required this.icon});

  final DateTime dateTime;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 6,
      children: [
        Icon(icon, size: 14),

        Text(
          dateTime.formattedString(),
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
