import 'package:google_tasks_clone/domain/repositories/user_repo.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@LazySingleton(as: UserRepo)
class UserRepoImpl extends UserRepo {
  UserRepoImpl(this._preferences);

  final SharedPreferences _preferences;

  static const String _preferenceKey = 'completed_onboarding';

  @override
  Future<bool> finishOnboarding() async {
    return _preferences.setBool(_preferenceKey, true);
  }

  @override
  Future<bool?> checkOnboarding() async {
    return _preferences.getBool(_preferenceKey);
  }
}
