import 'package:flutter/material.dart';
import 'package:google_tasks_clone/domain/entities/task_entity.dart';
import 'package:google_tasks_clone/presentation/features/dashboard/ui/widgets/task_date_time.dart';

class TaskDescription extends StatelessWidget {
  const TaskDescription({super.key, required this.task});

  final TaskEntity task;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: .symmetric(vertical: 4),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 6,
        children: [
          // Description
          if (task.description != null && task.description!.isNotEmpty)
            Text(
              task.description!,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 13),
            ),

          task.isSubtask
              ? Column(
                  spacing: 6,
                  children: [
                    // Deadline
                    if (task.deadline != null)
                      TaskDateTime(
                        dateTime: task.deadline!,
                        icon: Icons.track_changes,
                      ),

                    // DateTime
                    if (task.dateTime != null)
                      TaskDateTime(dateTime: task.dateTime!, icon: Icons.event),
                  ],
                )
              : Row(
                  spacing: 6,
                  children: [
                    // Deadline
                    if (task.deadline != null) ...[
                      TaskDateTime(
                        dateTime: task.deadline!,
                        icon: Icons.track_changes,
                      ),

                      SizedBox(width: 8),
                    ],

                    // DateTime
                    if (task.dateTime != null)
                      TaskDateTime(dateTime: task.dateTime!, icon: Icons.event),
                  ],
                ),
        ],
      ),
    );
  }
}
