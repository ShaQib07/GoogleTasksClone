import 'package:auto_route/annotations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_tasks_clone/domain/entities/task_entity.dart';
import 'package:google_tasks_clone/domain/entities/task_group_entity.dart';
import 'package:google_tasks_clone/presentation/features/task_detail/ui/task_detail_body.dart';

import '../../../di/injection.dart';
import 'cubit/task_detail_cubit.dart';

@RoutePage()
class TaskDetailPage extends StatelessWidget {
  const TaskDetailPage({
    super.key,
    required this.task,
    required this.taskGroupList,
  });

  final TaskEntity task;
  final List<TaskGroupEntity> taskGroupList;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TaskDetailCubit>(
      create: (context) => injector(param1: task),
      child: TaskDetailBody(task: task, taskGroupList: taskGroupList),
    );
  }
}
