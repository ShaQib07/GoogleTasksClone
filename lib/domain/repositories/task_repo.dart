import '../entities/task_entity.dart';

abstract class TaskRepo {
  Future<void> createTask(TaskEntity task);
  Stream<List<TaskEntity>> readTasks();
  Future<void> updateTab(TaskEntity task);
  Future<void> deleteTab(TaskEntity task);
}
