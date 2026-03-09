import 'package:flutter/material.dart';
import 'package:google_tasks_clone/domain/entities/task_tab_entity.dart';
import 'package:google_tasks_clone/presentation/screens/dashboard/ui/widgets/empty_task_view.dart';
import 'package:google_tasks_clone/presentation/screens/dashboard/ui/widgets/tab_toolbar.dart';
import 'package:google_tasks_clone/presentation/screens/dashboard/ui/widgets/task_item.dart';

import '../../../../domain/entities/task_entity.dart';
import '../../../../resources/app_strings.dart';

class StarredListView extends StatelessWidget {
  const StarredListView({
    super.key,
    required this.tasks,
    required this.onSortPressed,
    required this.onTaskTap,
    required this.onTaskChecked,
    required this.onTaskStarred,
  });

  final List<TaskEntity> tasks;
  final VoidCallback onSortPressed;
  final Function(TaskEntity task) onTaskTap;
  final Function(TaskEntity task, bool value) onTaskChecked;
  final Function(TaskEntity task, bool value) onTaskStarred;

  @override
  Widget build(BuildContext context) {
    if (tasks.isEmpty) {
      return EmptyTaskView(
        tab: TaskTabEntity(tabName: AppStrings.starred),
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
                    tab: TaskTabEntity(tabName: AppStrings.starred),
                    onSortPressed: onSortPressed,
                  ),
                ),
              ],
            ),
          ),

          Card(
            margin: EdgeInsets.symmetric(horizontal: 8),
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
                  onTap: () {
                    onTaskTap(task);
                  },
                  onChecked: (value) {
                    onTaskChecked(task, value ?? false);
                  },
                  onStarred: (value) {
                    onTaskStarred(task, value);
                  },
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
