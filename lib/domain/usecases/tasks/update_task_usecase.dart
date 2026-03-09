import 'package:injectable/injectable.dart';

import '../../entities/task_entity.dart';
import '../../repositories/task_repo.dart';

@injectable
class UpdateTaskUsecase {
  final TaskRepo _taskRepo;

  UpdateTaskUsecase(this._taskRepo);

  Future<void> run(TaskEntity task) => _taskRepo.updateTask(task);
}
