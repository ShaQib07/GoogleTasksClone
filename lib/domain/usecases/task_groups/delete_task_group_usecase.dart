import 'package:injectable/injectable.dart';

import '../../repositories/task_group_repo.dart';
import '../../repositories/task_repo.dart';

@injectable
class DeleteTaskGroupUsecase {
  final TaskGroupRepo _taskGroupRepo;
  final TaskRepo _taskRepo;

  DeleteTaskGroupUsecase(this._taskGroupRepo, this._taskRepo);

  Future<void> run(int taskGroupId) async {
    await _taskGroupRepo.deleteTaskGroup(taskGroupId);
    await _taskRepo.deleteTaskByTaskGroupId(taskGroupId);
  }
}
