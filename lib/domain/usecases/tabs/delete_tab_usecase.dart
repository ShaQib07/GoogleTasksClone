import 'package:injectable/injectable.dart';

import '../../repositories/tab_repo.dart';
import '../../repositories/task_repo.dart';

@injectable
class DeleteTabUsecase {
  final TabRepo _tabRepo;
  final TaskRepo _taskRepo;

  DeleteTabUsecase(this._tabRepo, this._taskRepo);

  Future<void> run(int tabId) async {
    await _tabRepo.deleteTab(tabId);
    await _taskRepo.deleteTaskByTabId(tabId);
  }
}
