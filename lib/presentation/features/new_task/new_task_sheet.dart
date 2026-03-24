import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_tasks_clone/presentation/features/new_task/ui/new_task_body.dart';

import '../../../di/injection.dart';
import 'cubit/new_task_cubit.dart';

class NewTaskSheet extends StatelessWidget {
  const NewTaskSheet({super.key, this.tabId});

  final int? tabId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NewTaskCubit>(
      create: (_) => injector(),
      child: NewTaskBody(tabId: tabId),
    );
  }
}
