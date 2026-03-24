import 'package:auto_route/annotations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_tasks_clone/domain/entities/task_group_entity.dart';
import 'package:google_tasks_clone/presentation/features/create_list/cubit/create_list_cubit.dart';
import 'package:google_tasks_clone/presentation/features/create_list/ui/create_list_body.dart';

import '../../../di/injection.dart';

@RoutePage()
class CreateListPage extends StatelessWidget {
  const CreateListPage({super.key, this.tab});

  final TaskGroupEntity? tab;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CreateListCubit>(
        create: (context) => injector(),
        child: CreateListBody(tab: tab)
    );
  }
}
