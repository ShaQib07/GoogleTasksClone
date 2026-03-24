import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:google_tasks_clone/data/database/tables/task_group_table.dart';
import 'package:google_tasks_clone/data/database/tables/task_table.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [TaskGroupTable, TaskTable])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  // TaskGroup
  Future<void> insertTaskGroup(TaskGroupTableCompanion tab) =>
      into(taskGroupTable).insert(tab, mode: InsertMode.insertOrReplace);

  Stream<List<TaskGroupTableData>> watchTaskGroup() =>
      select(taskGroupTable).watch();

  Future<void> updateTaskGroup(TaskGroupTableData tab) =>
      update(taskGroupTable).replace(tab);

  Future<void> deleteTaskGroupById(int id) =>
      (delete(taskGroupTable)..where((tab) => tab.id.equals(id))).go();

  // Task
  Future<void> insertTasks(List<TaskTableCompanion> tasks) => batch((batch) {
    batch.insertAllOnConflictUpdate(taskTable, tasks);
  });

  Stream<List<TaskTableData>> watchTasks() => select(taskTable).watch();

  Stream<List<TaskTableData>> watchTaskById(int id) =>
      (select(taskTable)..where(
            (task) => (task.id.equals(id) | task.parentTaskId.equals(id)),
          ))
          .watch();

  Future<void> updateTask(TaskTableData task) =>
      update(taskTable).replace(task);

  Future<void> deleteTasks(List<int> taskIds) =>
      (delete(taskTable)..where((table) => table.id.isIn(taskIds))).go();

  Future<void> deleteTasksByTaskGroupId(int taskGroupId) => (delete(
    taskTable,
  )..where((task) => task.taskGroupId.equals(taskGroupId))).go();

  Future<void> deleteTasksByParentTaskId(int parentTaskId) => (delete(
    taskTable,
  )..where((task) => task.parentTaskId.equals(parentTaskId))).go();
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationSupportDirectory();
    final file = File(p.join(dir.path, 'db.sqlite'));
    return NativeDatabase.createBackgroundConnection(file);
  });
}
