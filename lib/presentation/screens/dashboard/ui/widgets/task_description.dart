import 'package:flutter/material.dart';
import 'package:google_tasks_clone/domain/entities/task_entity.dart';

import '../../../../../core/extensions/date_time.dart';

class TaskDescription extends StatelessWidget {
  const TaskDescription({super.key, required this.task});

  final TaskEntity task;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 4,
      children: [
        // Description
        if (task.description != null)
          Text(
            task.description!,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 13),
          ),

        Row(
          spacing: 6,
          children: [
            // Deadline
            if (task.deadline != null) ...[
              Icon(Icons.track_changes, size: 14),

              Text(
                task.deadline!.formattedString(),
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),

              SizedBox(width: 8),
            ],

            // DateTime
            if (task.dateTime != null) ...[
              Icon(Icons.event, size: 14),

              Text(
                task.dateTime!.formattedString(),
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ],
          ],
        ),
      ],
    );
  }
}
