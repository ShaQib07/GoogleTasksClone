import 'package:drift/drift.dart';
import 'package:google_tasks_clone/data/database/app_database.dart';

import '../../domain/entities/task_entity.dart';

extension TaskEntityMapper on TaskEntity {
  TaskTableCompanion toCompanion() {
    return TaskTableCompanion.insert(
      id: id == null ? Value.absent() : Value(id!),
      taskGroupId: taskGroupId,
      parentTaskId: Value(parentTaskId),
      title: title,
      description: Value(description),
      dateAndTime: Value(dateTime),
      deadline: Value(deadline),
      isFavorite: Value(isFavorite),
      isCompleted: Value(isCompleted),
      createdAt: createdAt,
      isSubtask: Value(isSubtask),
    );
  }

  TaskTableData toTableData() {
    return TaskTableData(
      id: id ?? 0,
      taskGroupId: taskGroupId,
      parentTaskId: parentTaskId,
      title: title,
      description: description,
      dateAndTime: dateTime,
      deadline: deadline,
      isFavorite: isFavorite,
      isCompleted: isCompleted,
      createdAt: createdAt,
      isSubtask: isSubtask,
    );
  }
}

extension TaskTableDataMapper on TaskTableData {
  TaskEntity toEntity() {
    return TaskEntity(
      id: id,
      taskGroupId: taskGroupId,
      parentTaskId: parentTaskId,
      title: title,
      description: description,
      dateTime: dateAndTime,
      deadline: deadline,
      isFavorite: isFavorite,
      isCompleted: isCompleted,
      createdAt: createdAt,
      isSubtask: isSubtask,
    );
  }
}
