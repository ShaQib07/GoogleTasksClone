import 'package:google_tasks_clone/domain/entities/task_group_entity.dart';
import 'package:google_tasks_clone/domain/repositories/task_group_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class CreateTaskGroupUsecase {
  final TaskGroupRepo _taskGroupRepo;

  CreateTaskGroupUsecase(this._taskGroupRepo);

  Future<void> run(TaskGroupEntity taskGroup) =>
      _taskGroupRepo.createTaskGroup(taskGroup);
}
