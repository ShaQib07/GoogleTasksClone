import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:google_tasks_clone/di/injection.dart';
import 'package:google_tasks_clone/presentation/core/resources/app_strings.dart';
import 'package:google_tasks_clone/presentation/core/resources/app_theme.dart';
import 'package:google_tasks_clone/presentation/core/routes/router.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final appRouter = injector.get<AppRouter>();

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      title: AppStrings.appTitle,
      routerDelegate: AutoRouterDelegate(appRouter),
      routeInformationParser: appRouter.defaultRouteParser(),
    );
  }
}
