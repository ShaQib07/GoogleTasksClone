import 'package:google_tasks_clone/domain/entities/task_tab_entity.dart';
import 'package:injectable/injectable.dart';

import '../../domain/repositories/tab_repo.dart';
import '../database/app_database.dart';

@LazySingleton(as: TabRepo)
class TabRepoImpl extends TabRepo {
  TabRepoImpl(this._db);

  final AppDatabase _db;

  @override
  Future<void> createTab(TaskTabEntity tab) async {
    _db.insertTaskTab(TaskTabTableCompanion.insert(tabName: tab.tabName));
  }

  @override
  Stream<List<TaskTabEntity>> readTab() {
    return _db.watchTaskTabs().map(
      (tabs) => tabs
          .map((tab) => TaskTabEntity(id: tab.id, tabName: tab.tabName))
          .toList(),
    );
  }

  @override
  Future<void> updateTab(TaskTabEntity tab) async {
    _db.updateTaskTab(TaskTabTableData(id: tab.id ?? 0, tabName: tab.tabName));
  }

  @override
  Future<void> deleteTab(int id) async {
    _db.deleteTaskTabById(id);
  }
}
