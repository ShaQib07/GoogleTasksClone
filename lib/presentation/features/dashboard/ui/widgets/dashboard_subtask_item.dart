import 'package:flutter/material.dart';
import 'package:google_tasks_clone/presentation/features/dashboard/ui/widgets/task_description.dart';

import '../../../../../domain/entities/task_entity.dart';
import '../../../../core/widgets/icon_star.dart';

class DashboardSubtaskItem extends StatelessWidget {
  const DashboardSubtaskItem({
    super.key,
    required this.subtask,
    required this.onSubtaskTap,
    required this.onSubtaskCheckChanged,
    required this.onSubtaskStarToggle,
  });

  final TaskEntity subtask;
  final VoidCallback onSubtaskTap;
  final VoidCallback onSubtaskCheckChanged;
  final VoidCallback onSubtaskStarToggle;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onSubtaskTap,
      child: Padding(
        padding: .only(left: 44, right: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Checkbox
            Transform.scale(
              scale: 1.1,
              child: Checkbox(
                shape: const CircleBorder(),
                value: subtask.isCompleted,
                onChanged: (_) => onSubtaskCheckChanged(),
              ),
            ),

            Expanded(
              child: Padding(
                padding: .only(top: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      subtask.title,
                      style: TextStyle(
                        fontSize: 16,
                        decoration: subtask.isCompleted
                            ? TextDecoration.lineThrough
                            : null,
                      ),
                    ),

                    // Description
                    TaskDescription(task: subtask),
                    
                  ],
                ),
              ),
            ),

            IconStar(isStarred: subtask.isFavorite, onStarToggle: onSubtaskStarToggle),
          ],
        ),
      ),
    );
  }
}