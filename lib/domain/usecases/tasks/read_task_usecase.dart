import 'package:google_tasks_clone/domain/entities/task_entity.dart';
import 'package:injectable/injectable.dart';

import '../../repositories/task_repo.dart';

@injectable
class ReadTaskUsecase {
  final TaskRepo _taskRepo;

  ReadTaskUsecase(this._taskRepo);

  Stream<List<TaskEntity>> run() => _taskRepo.readTasks();
}
