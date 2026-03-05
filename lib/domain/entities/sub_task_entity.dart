class SubTaskEntity {
  final int id;
  final int parentTaskId;
  final String title;
  final String? description;
  final String? deadline;
  final String? reminder;
  final bool isFavorite;
  final bool isCompleted;

  const SubTaskEntity({
    required this.id,
    required this.parentTaskId,
    required this.title,
    this.description,
    this.deadline,
    this.reminder,
    required this.isFavorite,
    required this.isCompleted,
  });
}
