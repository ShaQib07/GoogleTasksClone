import 'package:google_tasks_clone/domain/entities/task_group_entity.dart';

abstract class TaskGroupRepo {
  Future<void> createTaskGroup(TaskGroupEntity taskGroup);
  Stream<List<TaskGroupEntity>> readTaskGroup();
  Future<void> updateTaskGroup(TaskGroupEntity taskGroup);
  Future<void> deleteTaskGroup(int id);
}
