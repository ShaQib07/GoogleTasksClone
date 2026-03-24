import '../presentation/core/routes/router.dart';
import 'injection.dart';

class DependencyManager {
  static Future<void> inject() async {
    injector.registerLazySingleton<AppRouter>(() => AppRouter());

    await configureDependencies();
  }
}
