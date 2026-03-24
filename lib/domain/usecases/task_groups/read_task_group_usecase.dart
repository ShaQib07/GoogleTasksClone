import 'package:google_tasks_clone/domain/entities/task_group_entity.dart';
import 'package:injectable/injectable.dart';

import '../../repositories/task_group_repo.dart';

@injectable
class ReadTaskGroupUsecase {
  final TaskGroupRepo _taskGroupRepo;

  ReadTaskGroupUsecase(this._taskGroupRepo);

  Stream<List<TaskGroupEntity>> run() => _taskGroupRepo.readTaskGroup();
}
