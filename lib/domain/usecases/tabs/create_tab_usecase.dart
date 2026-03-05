import 'package:google_tasks_clone/domain/entities/task_tab_entity.dart';
import 'package:google_tasks_clone/domain/repositories/tab_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class CreateTabUsecase {
  final TabRepo _tabRepo;

  CreateTabUsecase(this._tabRepo);

  Future<void> run(TaskTabEntity tab) => _tabRepo.createTab(tab);
}
