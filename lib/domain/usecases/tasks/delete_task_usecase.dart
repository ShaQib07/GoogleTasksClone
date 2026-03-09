import 'package:injectable/injectable.dart';

import '../../entities/task_entity.dart';
import '../../repositories/task_repo.dart';

@injectable
class DeleteTaskUsecase {
  final TaskRepo _taskRepo;

  DeleteTaskUsecase(this._taskRepo);

  Future<void> run(List<TaskEntity> task) => _taskRepo.deleteTasks(task);
}
