import 'package:google_tasks_clone/domain/entities/task_group_entity.dart';
import 'package:injectable/injectable.dart';

import '../../domain/repositories/task_group_repo.dart';
import '../database/app_database.dart';

@LazySingleton(as: TaskGroupRepo)
class TaskGroupRepoImpl extends TaskGroupRepo {
  TaskGroupRepoImpl(this._db);

  final AppDatabase _db;

  @override
  Future<void> createTaskGroup(TaskGroupEntity taskGroup) async {
    _db.insertTaskGroup(TaskGroupTableCompanion.insert(tabName: taskGroup.title));
  }

  @override
  Stream<List<TaskGroupEntity>> readTaskGroup() {
    return _db.watchTaskGroup().map(
      (tabs) => tabs
          .map((tab) => TaskGroupEntity(id: tab.id, title: tab.tabName))
          .toList(),
    );
  }

  @override
  Future<void> updateTaskGroup(TaskGroupEntity taskGroup) async {
    _db.updateTaskGroup(TaskGroupTableData(id: taskGroup.id ?? 0, tabName: taskGroup.title));
  }

  @override
  Future<void> deleteTaskGroup(int id) async {
    _db.deleteTaskGroupById(id);
  }
}
