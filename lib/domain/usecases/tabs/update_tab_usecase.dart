import 'package:google_tasks_clone/domain/entities/task_tab_entity.dart';
import 'package:injectable/injectable.dart';

import '../../repositories/tab_repo.dart';

@injectable
class UpdateTabUsecase {
  final TabRepo _tabRepo;

  UpdateTabUsecase(this._tabRepo);

  Future<void> run(TaskTabEntity tab) => _tabRepo.updateTab(tab);
}
