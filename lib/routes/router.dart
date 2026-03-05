import 'package:auto_route/auto_route.dart';
import 'package:google_tasks_clone/routes/router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {

  @override
  RouteType get defaultRouteType => RouteType.material();
  
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: OnboardingRoute.page, initial: true),

    AutoRoute(page: DashboardRoute.page),

    AutoRoute(page: CreateListRoute.page),
  ];
}
