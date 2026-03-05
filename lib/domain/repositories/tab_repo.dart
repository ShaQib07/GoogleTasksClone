import 'package:google_tasks_clone/domain/entities/task_tab_entity.dart';

abstract class TabRepo {
  Future<void> createTab(TaskTabEntity tab);
  Stream<List<TaskTabEntity>> readTab();
  Future<void> updateTab(TaskTabEntity tab);
  Future<void> deleteTab(int id);
}
