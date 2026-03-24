import 'package:injectable/injectable.dart';

import '../../entities/task_entity.dart';
import '../../repositories/task_repo.dart';

@injectable
class DeleteTaskUsecase {
  final TaskRepo _taskRepo;

  DeleteTaskUsecase(this._taskRepo);

  Future<void> run(List<TaskEntity> tasks) async {
    for (final task in tasks) {
      await _taskRepo.deleteTaskByParentTaskId(task.id!);
    }

    await _taskRepo.deleteTasks(tasks);
  }
}
