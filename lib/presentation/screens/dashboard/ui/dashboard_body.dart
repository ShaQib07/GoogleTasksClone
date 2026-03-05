import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_tasks_clone/presentation/screens/dashboard/cubit/dashboard_cubit.dart';
import 'package:google_tasks_clone/presentation/screens/dashboard/cubit/dashboard_state.dart';
import 'package:google_tasks_clone/presentation/screens/dashboard/ui/starred_list_view.dart';
import 'package:google_tasks_clone/presentation/screens/dashboard/ui/task_list_view.dart';
import 'package:google_tasks_clone/presentation/screens/dashboard/ui/widgets/list_action_sheet.dart';
import 'package:google_tasks_clone/presentation/screens/dashboard/ui/widgets/task_tab_bar.dart';
import 'package:google_tasks_clone/presentation/screens/task/new_task_sheet.dart';
import 'package:google_tasks_clone/resources/app_strings.dart';

import '../../../../routes/router.gr.dart';

class DashboardBody extends StatelessWidget {
  const DashboardBody({super.key});

  void _openNewTaskSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => const NewTaskSheet(),
    );
  }

  Future<ListAction?> _openListActionSheet(
    BuildContext context,
    bool hasCompletedTasks,
  ) {
    return showModalBottomSheet<ListAction>(
      context: context,
      useSafeArea: true,
      builder: (_) => ListActionSheet(hasCompletedTasks: hasCompletedTasks),
    );
  }

  void _openSortOptionSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => const NewTaskSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final router = context.router;
    final cubit = context.read<DashboardCubit>();

    return BlocBuilder<DashboardCubit, DashboardState>(
      builder: (context, state) {
        return DefaultTabController(
          length: state.tabList.length + 1,
          child: Scaffold(
            appBar: AppBar(
              title: const Text(
                AppStrings.tasks,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(48),
                child: TaskTabBar(
                  tabs: cubit.state.tabList,
                  onCreateNewList: () => router.push(CreateListRoute()),
                ),
              ),
            ),
            body: TabBarView(
              children: [
                StarredListView(
                  tasks: cubit.getStarredTasks(),
                  onSortPressed: () => _openSortOptionSheet(context),
                ),

                for (var tab in state.tabList)
                  TaskListView(
                    taskTab: tab,
                    tasks: cubit.getTasksForTab(tab.id),
                    onMorePressed: () async {
                      final action = await _openListActionSheet(context, false);

                      if (action == null) return;

                      switch (action) {
                        case ListAction.rename:
                          router.push(CreateListRoute(tab: tab));
                        case ListAction.delete:
                          cubit.deleteTab(tab.id);
                        case ListAction.deleteCompleted:
                        //cubit.deleteCompletedTasks();
                      }
                    },
                    onSortPressed: () => _openSortOptionSheet(context),
                  ),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () => _openNewTaskSheet(context),
              child: Icon(Icons.add),
            ),
          ),
        );
      },
    );
  }
}
