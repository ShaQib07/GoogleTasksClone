import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_tasks_clone/presentation/screens/task/cubit/task_cubit.dart';
import 'package:google_tasks_clone/presentation/screens/task/ui/new_task_body.dart';

import '../../../di/injection.dart';

class NewTaskSheet extends StatelessWidget {
  const NewTaskSheet({super.key, this.tabId});

  final int? tabId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TaskCubit>(
      create: (_) => injector(),
      child: NewTaskBody(tabId: tabId),
    );
  }
}
