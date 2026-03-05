import 'package:injectable/injectable.dart';

import '../../repositories/user_repo.dart';

@injectable
class CheckOnboardingUsecase {
  final UserRepo _userRepo;

  CheckOnboardingUsecase(this._userRepo);

  Future<bool?> run() => _userRepo.checkOnboarding();
}
