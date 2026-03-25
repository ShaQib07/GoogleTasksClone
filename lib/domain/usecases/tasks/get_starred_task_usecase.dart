import 'package:injectable/injectable.dart';

import '../../entities/task_entity.dart';
import '../../repositories/task_repo.dart';

@injectable
class GetStarredTaskUsecase {
  final TaskRepo _taskRepo;

  GetStarredTaskUsecase(this._taskRepo);

  Stream<List<TaskEntity>> run() => _taskRepo.readTasks().map(
    (tasks) => tasks.where((task) => task.isFavorite).toList(),
  );
}
