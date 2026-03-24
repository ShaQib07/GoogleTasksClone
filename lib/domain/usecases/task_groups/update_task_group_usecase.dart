import 'package:google_tasks_clone/domain/entities/task_group_entity.dart';
import 'package:injectable/injectable.dart';

import '../../repositories/task_group_repo.dart';

@injectable
class UpdateTaskGroupUsecase {
  final TaskGroupRepo _taskGroupRepo;

  UpdateTaskGroupUsecase(this._taskGroupRepo);

  Future<void> run(TaskGroupEntity taskGroup) =>
      _taskGroupRepo.updateTaskGroup(taskGroup);
}
