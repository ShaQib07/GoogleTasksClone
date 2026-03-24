import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_tasks_clone/presentation/features/dashboard/cubit/dashboard_cubit.dart';
import 'package:google_tasks_clone/presentation/features/dashboard/ui/dashboard_body.dart';

import '../../../di/injection.dart';

@RoutePage()
class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DashboardCubit>(
      create: (context) => injector(),
      child: const DashboardBody(),
    );
  }
}
