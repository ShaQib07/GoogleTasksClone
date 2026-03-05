import 'package:drift/drift.dart';
import 'package:google_tasks_clone/data/database/app_database.dart';

import '../../domain/entities/task_entity.dart';

extension TaskEntityMapper on TaskEntity {
  TaskTableCompanion toCompanion() {
    return TaskTableCompanion.insert(
      tabId: tabId,
      title: title,
      description: Value(description),
      deadline: Value(deadline),
      reminder: Value(reminder),
      isFavorite: Value(isFavorite),
      isCompleted: Value(isCompleted),
    );
  }
}

extension TaskTableDataMapper on TaskTableData {
  TaskEntity toEntity() {
    return TaskEntity(
      tabId: tabId,
      title: title,
      description: description,
      deadline: deadline,
      reminder: reminder,
      isFavorite: isFavorite,
      isCompleted: isCompleted,
    );
  }
}
