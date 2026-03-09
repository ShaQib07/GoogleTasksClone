import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:google_tasks_clone/data/database/tables/tab_table.dart';
import 'package:google_tasks_clone/data/database/tables/task_table.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [TaskTabTable, TaskTable])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<void> insertTaskTab(TaskTabTableCompanion tab) =>
      into(taskTabTable).insert(tab, mode: InsertMode.insertOrReplace);

  Stream<List<TaskTabTableData>> watchTaskTabs() =>
      select(taskTabTable).watch();

  Future<void> updateTaskTab(TaskTabTableData tab) =>
      update(taskTabTable).replace(tab);

  Future<void> deleteTaskTabById(int id) =>
      (delete(taskTabTable)..where((tab) => tab.id.equals(id))).go();

  Future<void> insertTask(TaskTableCompanion task) =>
      into(taskTable).insert(task, mode: InsertMode.insertOrReplace);

  Stream<List<TaskTableData>> watchTasks() => select(taskTable).watch();

  Future<void> updateTask(TaskTableData task) =>
      update(taskTable).replace(task);

  Future<void> deleteTasks(List<int> taskIds) =>
      (delete(taskTable)..where((tbl) => tbl.id.isIn(taskIds))).go();

  Future<void> deleteTasksByTabId(int tabId) =>
      (delete(taskTable)..where((task) => task.tabId.equals(tabId))).go();
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationSupportDirectory();
    final file = File(p.join(dir.path, 'db.sqlite'));
    return NativeDatabase.createBackgroundConnection(file);
  });
}
