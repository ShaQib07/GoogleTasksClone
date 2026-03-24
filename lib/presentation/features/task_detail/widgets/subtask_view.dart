import 'package:flutter/material.dart';
import 'package:google_tasks_clone/presentation/core/resources/app_strings.dart';
import 'package:google_tasks_clone/presentation/features/task_detail/widgets/subtask_item.dart';

import '../../../../domain/entities/task_entity.dart';

class SubtaskView extends StatelessWidget {
  const SubtaskView({
    super.key,
    required this.subtasks,
    required this.onAddSubtask,
    required this.onTitleChanged,
    required this.onCheckChanged,
    required this.onDismiss,
  });

  final List<TaskEntity> subtasks;
  final VoidCallback onAddSubtask;
  final Function(TaskEntity subtask, String title) onTitleChanged;
  final Function(TaskEntity subtask) onCheckChanged;
  final Function(TaskEntity subtask) onDismiss;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: .start,
      children: [
        Padding(
          padding: .only(top: 16),
          child: Icon(Icons.subdirectory_arrow_right),
        ),

        Expanded(
          child: Padding(
            padding: .only(top: subtasks.isEmpty ? 16 : 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (final subtask in subtasks)
                  SubtaskItem(
                    subtask: subtask,
                    onTitleChange: (title) => onTitleChanged(subtask, title),
                    onCheckChanged: () => onCheckChanged(subtask),
                    onDismiss: () => onDismiss(subtask),
                  ),

                Padding(
                  padding: subtasks.isNotEmpty ? .symmetric(vertical: 16, horizontal: 24) : .zero,
                  child: InkWell(
                    onTap: onAddSubtask,
                    child: Padding(
                      padding: .symmetric(horizontal: 16),
                      child: Text(
                        AppStrings.addSubtask,
                        style: const TextStyle(fontSize: 15),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
