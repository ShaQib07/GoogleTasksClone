import 'package:google_tasks_clone/domain/entities/sub_task_entity.dart';

class TaskEntity {
  final int? id;
  final int tabId;
  final String title;
  final String? description;
  final String? deadline;
  final String? reminder;
  final bool isFavorite;
  final bool isCompleted;
  final List<SubTaskEntity>? subtasks;

  const TaskEntity({
    this.id,
    required this.tabId,
    required this.title,
    this.description,
    this.deadline,
    this.reminder,
    required this.isFavorite,
    required this.isCompleted,
    this.subtasks,
  });

  TaskEntity copyWith({
    int? id,
    int? tabId,
    String? title,
    String? description,
    String? deadline,
    String? reminder,
    bool? isFavorite,
    bool? isCompleted,
    List<SubTaskEntity>? subtasks,
  }) {
    return TaskEntity(
      id: id ?? this.id,
      tabId: tabId ?? this.tabId,
      title: title ?? this.title,
      description: description ?? this.description,
      deadline: deadline ?? this.deadline,
      reminder: reminder ?? this.reminder,
      isFavorite: isFavorite ?? this.isFavorite,
      isCompleted: isCompleted ?? this.isCompleted,
      subtasks: subtasks ?? this.subtasks,
    );
  }
}
