import 'package:google_tasks_clone/domain/repositories/task_repo.dart';
import 'package:injectable/injectable.dart';

import '../../entities/task_entity.dart';

@injectable
class CreateTaskUsecase {
  final TaskRepo _taskRepo;

  CreateTaskUsecase(this._taskRepo);

  Future<void> run(List<TaskEntity> taskList) => _taskRepo.createTasks(taskList);
}
