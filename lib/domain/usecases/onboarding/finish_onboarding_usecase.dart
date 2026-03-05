import 'package:injectable/injectable.dart';

import '../../repositories/user_repo.dart';

@injectable
class FinishOnboardingUsecase {
  final UserRepo _userRepo;

  FinishOnboardingUsecase(this._userRepo);

  Future<void> run() => _userRepo.finishOnboarding();
}
