import 'package:injectable/injectable.dart';

import '../../repositories/tab_repo.dart';

@injectable
class DeleteTabUsecase {
  final TabRepo _tabRepo;

  DeleteTabUsecase(this._tabRepo);

  Future<void> run(int tabId) => _tabRepo.deleteTab(tabId);
}
