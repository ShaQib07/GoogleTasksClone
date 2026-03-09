import '../entities/task_entity.dart';

abstract class TaskRepo {
  Future<void> createTask(TaskEntity task);
  Stream<List<TaskEntity>> readTasks();
  Future<void> updateTask(TaskEntity task);
  Future<void> deleteTasks(List<TaskEntity> task);
  Future<void> deleteTaskByTabId(int tabId);
}
