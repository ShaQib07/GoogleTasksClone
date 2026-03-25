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
  Future<void> createTasks(List<TaskEntity> taskList) async =>
      _db.insertTasks(taskList.map((task) => task.toCompanion()).toList());

  @override
  Stream<List<TaskEntity>> readTasks() =>
      _db.watchTasks().map((rows) => rows.map((t) => t.toEntity()).toList());

  @override
  Stream<TaskEntity> readTaskById(int id) {
    return _db.watchTaskById(id).map((rows) {
      final tasks = rows.map((t) => t.toEntity()).toList();

      final task = tasks.firstWhere((task) => !task.isSubtask);

      return task.copyWith(
        subtasks: tasks.where((task) => task.isSubtask).toList(),
      );
    });
  }

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
  Future<void> deleteTaskByTaskGroupId(int taskGroupId) async =>
      _db.deleteTasksByTaskGroupId(taskGroupId);

  @override
  Future<void> deleteTaskByParentTaskId(int parentTaskId) async =>
      _db.deleteTasksByParentTaskId(parentTaskId);
}
