import 'package:google_tasks_clone/domain/entities/task_entity.dart';
import 'package:injectable/injectable.dart';

import '../../repositories/task_repo.dart';

@injectable
class ReadTaskUsecase {
  final TaskRepo _taskRepo;

  ReadTaskUsecase(this._taskRepo);

  Stream<List<TaskEntity>> run() {
    return _taskRepo.readTasks().map((tasks) {
      final subtasksByParent = <int, List<TaskEntity>>{};

      // mapping subtasks to their parent tasks
      for (final task in tasks) {
        if (task.parentTaskId != null && task.isSubtask) {
          subtasksByParent.putIfAbsent(task.parentTaskId!, () => []).add(task);
        }
      }

      return tasks
          .where((t) => !t.isSubtask)
          .map((t) => t.copyWith(subtasks: subtasksByParent[t.id] ?? []))
          .toList();
    });
  }
}
