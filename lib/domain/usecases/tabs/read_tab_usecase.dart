import 'package:google_tasks_clone/domain/entities/task_tab_entity.dart';
import 'package:injectable/injectable.dart';

import '../../repositories/tab_repo.dart';

@injectable
class ReadTabUsecase {
  final TabRepo _tabRepo;

  ReadTabUsecase(this._tabRepo);

  Stream<List<TaskTabEntity>> run() => _tabRepo.readTab();
}
