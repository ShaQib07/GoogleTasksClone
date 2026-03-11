import 'package:drift/drift.dart';
import 'package:google_tasks_clone/data/database/app_database.dart';

import '../../domain/entities/task_entity.dart';

extension TaskEntityMapper on TaskEntity {
  TaskTableCompanion toCompanion() {
    return TaskTableCompanion.insert(
      tabId: tabId,
      title: title,
      description: Value(description),
      dateAndTime: Value(dateTime),
      deadline: Value(deadline),
      reminder: Value(reminder),
      isFavorite: Value(isFavorite),
      isCompleted: Value(isCompleted),
      createdAt: createdAt,
    );
  }

  TaskTableData toTableData() {
    return TaskTableData(
      id: id ?? 0,
      tabId: tabId,
      title: title,
      description: description,
      dateAndTime: dateTime,
      deadline: deadline,
      reminder: reminder,
      isFavorite: isFavorite,
      isCompleted: isCompleted,
      createdAt: createdAt,
    );
  }
}

extension TaskTableDataMapper on TaskTableData {
  TaskEntity toEntity() {
    return TaskEntity(
      id: id,
      tabId: tabId,
      title: title,
      description: description,
      dateTime: dateAndTime,
      deadline: deadline,
      reminder: reminder,
      isFavorite: isFavorite,
      isCompleted: isCompleted,
      createdAt: createdAt,
    );
  }
}
