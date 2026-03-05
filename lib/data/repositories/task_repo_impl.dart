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
  Future<void> createTask(TaskEntity task) async {
    _db.insertTask(task.toCompanion());
  }

  @override
  Future<void> deleteTab(TaskEntity task) {
    // TODO: implement deleteTab
    throw UnimplementedError();
  }

  @override
  Stream<List<TaskEntity>> readTasks() {
    return _db.watchTasks().map(
          (tasks) => tasks
          .map((task) => task.toEntity())
          .toList(),
    );
  }

  @override
  Future<void> updateTab(TaskEntity task) {
    // TODO: implement updateTab
    throw UnimplementedError();
  }
}
