class TaskEntity {
  final int? id;
  final int taskGroupId;
  final int? parentTaskId;
  final String title;
  final String? description;
  final DateTime? dateTime;
  final DateTime? deadline;
  final bool isFavorite;
  final bool isCompleted;
  final DateTime createdAt;
  final bool isSubtask;
  final List<TaskEntity> subtasks;

  const TaskEntity({
    this.id,
    required this.taskGroupId,
    this.parentTaskId,
    required this.title,
    this.description,
    this.dateTime,
    this.deadline,
    this.isFavorite = false,
    this.isCompleted = false,
    required this.createdAt,
    this.isSubtask = false,
    this.subtasks = const [],
  });

  TaskEntity copyWith({
    int? id,
    int? taskGroupId,
    int? parentTaskId,
    String? title,
    String? description,
    (bool, DateTime?) dateTime = (false, null),
    (bool, DateTime?) deadline = (false, null),
    bool? isFavorite,
    bool? isCompleted,
    DateTime? createdAt,
    bool? isSubtask,
    List<TaskEntity>? subtasks,
  }) {
    return TaskEntity(
      id: id ?? this.id,
      taskGroupId: taskGroupId ?? this.taskGroupId,
      parentTaskId: parentTaskId ?? this.parentTaskId,
      title: title ?? this.title,
      description: description ?? this.description,
      dateTime: dateTime.$1 ? dateTime.$2 : this.dateTime,
      deadline: deadline.$1 ? deadline.$2 : this.deadline,
      isFavorite: isFavorite ?? this.isFavorite,
      isCompleted: isCompleted ?? this.isCompleted,
      createdAt: createdAt ?? this.createdAt,
      isSubtask: isSubtask ?? this.isSubtask,
      subtasks: subtasks ?? this.subtasks,
    );
  }

  @override
  String toString() {
    return 'TaskEntity(id: $id, taskGroupId: $taskGroupId, parentTaskId: $parentTaskId, title: $title, description: $description, dateTime: $dateTime, deadline: $deadline, isFavorite: $isFavorite, isCompleted: $isCompleted, createdAt: $createdAt, isSubtask: $isSubtask, subtasks: $subtasks)';
  }
}
