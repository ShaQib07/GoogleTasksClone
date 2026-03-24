import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

import '../../entities/task_entity.dart';
import '../../repositories/task_repo.dart';

@injectable
class UpdateTaskUsecase {
  final TaskRepo _taskRepo;

  UpdateTaskUsecase(this._taskRepo);

  Future<void> run(TaskEntity task) async {
    for (final subtask in task.subtasks) {
      Logger().d('GSK - UpdateTaskUsecase - $subtask');
    }
    _taskRepo.updateTask(task);
    _taskRepo.createTasks(task.subtasks);
  }
}
