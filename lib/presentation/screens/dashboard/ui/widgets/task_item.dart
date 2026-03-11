import 'package:flutter/material.dart';
import 'package:google_tasks_clone/domain/entities/task_entity.dart';
import 'package:google_tasks_clone/presentation/screens/dashboard/ui/widgets/task_description.dart';

class TaskItem extends StatelessWidget {
  final TaskEntity task;
  final VoidCallback onTap;
  final ValueChanged<bool?> onChecked;
  final ValueChanged<bool> onStarred;

  const TaskItem({
    super.key,
    required this.task,
    required this.onTap,
    required this.onChecked,
    required this.onStarred,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 12),
      horizontalTitleGap: 4,
      titleAlignment: ListTileTitleAlignment.top,
      leading: Transform.scale(
        scale: 1.2,
        child: Checkbox(
          shape: const CircleBorder(),
          value: task.isCompleted,
          onChanged: onChecked,
        ),
      ),

      title: Text(
        task.title,
        style: TextStyle(
          fontSize: 16,
          decoration: task.isCompleted ? TextDecoration.lineThrough : null,
        ),
      ),

      subtitle: TaskDescription(task: task),

      trailing: IconButton(
        onPressed: () => onStarred(!task.isFavorite),
        icon: task.isFavorite
            ? const Icon(Icons.star)
            : const Icon(Icons.star_border),
      ),

      onTap: onTap,
    );
  }
}
