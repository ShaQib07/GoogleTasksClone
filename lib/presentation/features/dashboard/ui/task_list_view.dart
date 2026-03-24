import 'package:flutter/material.dart';
import 'package:google_tasks_clone/domain/entities/task_group_entity.dart';
import 'package:google_tasks_clone/presentation/features/dashboard/ui/widgets/tab_toolbar.dart';
import 'package:google_tasks_clone/presentation/features/dashboard/ui/widgets/task_item.dart';

import '../../../../domain/entities/task_entity.dart';
import '../../../../presentation/core/resources/app_strings.dart';
import 'widgets/empty_task_view.dart';

class TaskListView extends StatelessWidget {
  const TaskListView({
    super.key,
    required this.taskTab,
    required this.tasks,
    required this.onMorePressed,
    required this.onSortPressed,
    required this.onTaskTap,
    required this.onTaskCheckChanged,
    required this.onTaskStarToggle,
    required this.onSubtaskTap,
    required this.onSubtaskCheckChanged,
    required this.onSubtaskStarToggle,
  });

  final TaskGroupEntity taskTab;
  final List<TaskEntity> tasks;
  final VoidCallback onMorePressed;
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
        tab: taskTab,
        primaryText: AppStrings.noTasksYet,
        secondaryText: AppStrings.addYourTodos,
        onMorePressed: onMorePressed,
        onSortPressed: onSortPressed,
      );
    }

    return SingleChildScrollView(
      child: Card(
        margin: EdgeInsetsGeometry.all(8),
        elevation: 0,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 6),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 24, right: 8),
                child: TabToolbar(
                  tab: taskTab,
                  onMorePressed: onMorePressed,
                  onSortPressed: onSortPressed,
                ),
              ),

              Column(
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
            ],
          ),
        ),
      ),
    );
  }
}
