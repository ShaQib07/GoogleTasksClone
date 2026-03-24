import 'package:flutter/material.dart';
import 'package:google_tasks_clone/domain/entities/task_group_entity.dart';

import '../../../core/resources/app_strings.dart';

class TaskGroupSelectionSheet extends StatelessWidget {
  const TaskGroupSelectionSheet({
    super.key,
    required this.taskGroupList,
    required this.currentTaskGroupId,
  });

  final List<TaskGroupEntity> taskGroupList;
  final int currentTaskGroupId;

  Widget _buildCheckIcon(TaskGroupEntity taskGroup) {
    return currentTaskGroupId == taskGroup.id
        ? const Icon(Icons.check)
        : const SizedBox(width: 24, height: 24);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Text(
              AppStrings.moveTaskTo,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
            ),
          ),

          for (var taskGroup in taskGroupList)
            ListTile(
              leading: _buildCheckIcon(taskGroup),
              title: Text(taskGroup.title),
              onTap: () => Navigator.pop(context, taskGroup.id),
            ),
        ],
      ),
    );
  }
}
