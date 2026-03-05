import 'package:flutter/material.dart';
import 'package:google_tasks_clone/domain/entities/task_tab_entity.dart';
import 'package:google_tasks_clone/presentation/screens/dashboard/ui/widgets/tab_toolbar.dart';
import 'package:google_tasks_clone/presentation/screens/dashboard/ui/widgets/task_item.dart';

import '../../../../domain/entities/task_entity.dart';
import '../../../../resources/app_strings.dart';
import 'widgets/empty_task_view.dart';

class TaskListView extends StatelessWidget {
  const TaskListView({
    super.key,
    required this.taskTab,
    required this.tasks,
    required this.onMorePressed,
    required this.onSortPressed,
  });

  final TaskTabEntity taskTab;
  final List<TaskEntity> tasks;
  final VoidCallback onMorePressed;
  final VoidCallback onSortPressed;

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
                    onTap: () {},
                    onChecked: (value) {},
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
