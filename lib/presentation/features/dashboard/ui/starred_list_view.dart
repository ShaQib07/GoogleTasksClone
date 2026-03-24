import 'package:flutter/material.dart';
import 'package:google_tasks_clone/domain/entities/task_group_entity.dart';
import 'package:google_tasks_clone/presentation/features/dashboard/ui/widgets/empty_task_view.dart';
import 'package:google_tasks_clone/presentation/features/dashboard/ui/widgets/tab_toolbar.dart';
import 'package:google_tasks_clone/presentation/features/dashboard/ui/widgets/task_item.dart';

import '../../../../domain/entities/task_entity.dart';
import '../../../../presentation/core/resources/app_strings.dart';

class StarredListView extends StatelessWidget {
  const StarredListView({
    super.key,
    required this.tasks,
    required this.onSortPressed,
    required this.onTaskTap,
    required this.onTaskCheckChanged,
    required this.onTaskStarToggle,
    required this.onSubtaskTap,
    required this.onSubtaskCheckChanged,
    required this.onSubtaskStarToggle,
  });

  final List<TaskEntity> tasks;
  final VoidCallback onSortPressed;
  final Function(TaskEntity task) onTaskTap;
  final Function(TaskEntity task) onTaskCheckChanged;
  final Function(TaskEntity task) onTaskStarToggle;
  final Function(TaskEntity task) onSubtaskTap;
  final Function(TaskEntity task) onSubtaskCheckChanged;
  final Function(TaskEntity task) onSubtaskStarToggle;

  @override
  Widget build(BuildContext context) {
    if (tasks.isEmpty) {
      return EmptyTaskView(
        tab: TaskGroupEntity(title: AppStrings.starred),
        primaryText: AppStrings.noStarredTasks,
        secondaryText: AppStrings.markImportantAsStarred,
        onSortPressed: onSortPressed,
      );
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          Card(
            margin: EdgeInsets.only(top: 8, bottom: 2, left: 8, right: 8),
            elevation: 0,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
                bottomLeft: Radius.circular(4),
                bottomRight: Radius.circular(4),
              ),
            ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: 24,
                    right: 8,
                    top: 6,
                    bottom: 4,
                  ),
                  child: TabToolbar(
                    tab: TaskGroupEntity(title: AppStrings.starred),
                    onSortPressed: onSortPressed,
                  ),
                ),
              ],
            ),
          ),

          Card(
            margin: EdgeInsets.symmetric(horizontal: 8),
            elevation: 0,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(4),
                bottom: Radius.circular(12),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: tasks.map((task) {
                return TaskItem(
                  task: task,
                  onTap: () => onTaskTap(task),
                  onCheckChanged: () => onTaskCheckChanged(task),
                  onStarToggle: () => onTaskStarToggle(task),
                  onSubtaskTap: onSubtaskTap,
                  onSubtaskCheckChanged: onSubtaskCheckChanged,
                  onSubtaskStarToggle: onSubtaskStarToggle,
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
