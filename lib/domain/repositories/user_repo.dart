abstract class UserRepo {
  Future<bool> finishOnboarding();
  Future<bool?> checkOnboarding();
}
