import 'package:flutter/material.dart';
import 'package:google_tasks_clone/domain/entities/task_entity.dart';

class TaskItem extends StatelessWidget {
  final TaskEntity task;
  final VoidCallback onTap;
  final ValueChanged<bool?> onChecked;

  const TaskItem({
    super.key,
    required this.task,
    required this.onTap,
    required this.onChecked,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Checkbox(
                  shape: const CircleBorder(),
                  value: task.isCompleted,
                  onChanged: onChecked,
                ),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        task.title,
                        style: TextStyle(
                          fontSize: 16,
                          decoration: task.isCompleted
                              ? TextDecoration.lineThrough
                              : null,
                        ),
                      ),
                    ],
                  ),
                ),

                IconButton(
                  onPressed: () {},
                  icon: task.isFavorite
                      ? const Icon(Icons.star)
                      : const Icon(Icons.star_border),
                ),
              ],
            ),

            if (task.description != null && task.description!.isNotEmpty)
              Transform.translate(
                offset: const Offset(0, -8),
                child: Container(
                  padding: const EdgeInsets.only(
                    left: 48,
                    right: 48,
                    top: 0,
                    bottom: 4,
                  ),
                  child: Text(
                    task.description!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 13),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
