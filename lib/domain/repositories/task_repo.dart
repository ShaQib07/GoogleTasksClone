import '../entities/task_entity.dart';

abstract class TaskRepo {
  Future<void> createTasks(List<TaskEntity> taskList);
  Stream<List<TaskEntity>> readTasks();
  Stream<TaskEntity> readTaskById(int id);
  Future<void> updateTask(TaskEntity task);
  Future<void> deleteTasks(List<TaskEntity> task);
  Future<void> deleteTaskByTaskGroupId(int taskGroupId);
  Future<void> deleteTaskByParentTaskId(int parentTaskId);
}
