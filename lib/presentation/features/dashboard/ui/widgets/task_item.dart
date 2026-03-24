import 'package:flutter/material.dart';
import 'package:google_tasks_clone/domain/entities/task_entity.dart';
import 'package:google_tasks_clone/presentation/features/dashboard/ui/widgets/task_description.dart';

import '../../../../core/widgets/icon_star.dart';
import 'dashboard_subtask_item.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({
    super.key,
    required this.task,
    required this.onTap,
    required this.onCheckChanged,
    required this.onStarToggle,
    required this.onSubtaskTap,
    required this.onSubtaskCheckChanged,
    required this.onSubtaskStarToggle,
  });

  final TaskEntity task;
  final VoidCallback onTap;
  final VoidCallback onCheckChanged;
  final VoidCallback onStarToggle;
  final Function(TaskEntity) onSubtaskTap;
  final Function(TaskEntity) onSubtaskCheckChanged;
  final Function(TaskEntity) onSubtaskStarToggle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const .symmetric(horizontal: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Checkbox
                Transform.scale(
                  scale: 1.1,
                  child: Checkbox(
                    shape: const CircleBorder(),
                    value: task.isCompleted,
                    onChanged: (_) => onCheckChanged(),
                  ),
                ),

                Expanded(
                  child: Padding(
                    padding: .only(top: 12, bottom: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title
                        Text(
                          task.title,
                          style: TextStyle(
                            fontSize: 16,
                            decoration: task.isCompleted
                                ? TextDecoration.lineThrough
                                : null,
                          ),
                        ),

                        // Description
                        TaskDescription(task: task),
                      ],
                    ),
                  ),
                ),

                IconStar(
                  isStarred: task.isFavorite,
                  onStarToggle: onStarToggle,
                ),
              ],
            ),
          ),
        ),

        // Subtasks
        Column(
          mainAxisSize: MainAxisSize.min,
          children: task.subtasks.map((subtask) {
            return DashboardSubtaskItem(
              subtask: subtask,
              onSubtaskTap: () => onSubtaskTap(subtask),
              onSubtaskCheckChanged: () => onSubtaskCheckChanged(subtask),
              onSubtaskStarToggle: () => onSubtaskStarToggle(subtask),
            );
          }).toList(),
        ),
      ],
    );
  }
}
