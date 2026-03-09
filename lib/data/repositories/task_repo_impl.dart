import 'package:google_tasks_clone/data/mappers/task_mapper.dart';
import 'package:google_tasks_clone/domain/entities/task_entity.dart';
import 'package:injectable/injectable.dart';

import '../../domain/repositories/task_repo.dart';
import '../database/app_database.dart';

@LazySingleton(as: TaskRepo)
class TaskRepoImpl extends TaskRepo {
  TaskRepoImpl(this._db);

  final AppDatabase _db;

  @override
  Future<void> createTask(TaskEntity task) async =>
      _db.insertTask(task.toCompanion());

  @override
  Stream<List<TaskEntity>> readTasks() => _db.watchTasks().map(
    (tasks) => tasks.map((task) => task.toEntity()).toList(),
  );

  @override
  Future<void> updateTask(TaskEntity task) async =>
      _db.updateTask(task.toTableData());

  @override
  Future<void> deleteTasks(List<TaskEntity> tasks) async {
    if (tasks.isEmpty) return;
    final taskIds = tasks.map((task) => task.id ?? 0).toList();
    _db.deleteTasks(taskIds);
  }

  @override
  Future<void> deleteTaskByTabId(int tabId) async =>
      _db.deleteTasksByTabId(tabId);
}
