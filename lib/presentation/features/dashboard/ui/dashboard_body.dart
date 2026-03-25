import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_tasks_clone/presentation/core/resources/app_strings.dart';
import 'package:google_tasks_clone/presentation/features/dashboard/cubit/dashboard_cubit.dart';
import 'package:google_tasks_clone/presentation/features/dashboard/cubit/dashboard_state.dart';
import 'package:google_tasks_clone/presentation/features/dashboard/ui/list_action_sheet.dart';
import 'package:google_tasks_clone/presentation/features/dashboard/ui/sort_action_sheet.dart';
import 'package:google_tasks_clone/presentation/features/dashboard/ui/starred_list_view.dart';
import 'package:google_tasks_clone/presentation/features/dashboard/ui/task_list_view.dart';
import 'package:google_tasks_clone/presentation/features/dashboard/ui/widgets/task_tab_bar.dart';

import '../../../../presentation/core/routes/router.gr.dart';
import '../../new_task/new_task_sheet.dart';

class DashboardBody extends StatefulWidget {
  const DashboardBody({super.key});

  @override
  State<StatefulWidget> createState() => _DashboardBodyState();
}

class _DashboardBodyState extends State<DashboardBody>
    with TickerProviderStateMixin {
  late TabController _tabController;
  int _tabLength = 0;

  @override
  void initState() {
    super.initState();

    final cubit = context.read<DashboardCubit>();
    _tabLength = cubit.state.tabList.length + 1;

    _initController(cubit);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _initController(DashboardCubit cubit) {
    _tabController = TabController(length: _tabLength, vsync: this);

    _tabController.addListener(() {
      if (_tabController.indexIsChanging) return;

      cubit.onTabChanged(_tabController.index);
    });
  }

  void _openNewTaskSheet(BuildContext context, int? tabId) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => NewTaskSheet(tabId: tabId),
    );
  }

  Future<ListAction?> _openListActionSheet(
    BuildContext context,
    bool isDeletable,
    bool hasCompletedTasks,
  ) => showModalBottomSheet<ListAction>(
    context: context,
    useSafeArea: true,
    builder: (_) => ListActionSheet(
      isDeletable: isDeletable,
      hasCompletedTasks: hasCompletedTasks,
    ),
  );

  Future<SortAction?> _openSortOptionSheet(
    BuildContext context,
    SortAction sortAction,
  ) => showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (_) => SortActionSheet(currentSelection: sortAction),
  );

  @override
  Widget build(BuildContext context) {
    final router = context.router;
    final cubit = context.read<DashboardCubit>();

    return BlocListener<DashboardCubit, DashboardState>(
      listener: (context, state) {
        final newLength = state.tabList.length + 1;

        if (newLength != _tabLength) {
          _tabLength = newLength;

          _tabController.dispose();
          _initController(context.read<DashboardCubit>());
        }

        _tabController.animateTo(state.selectedTab);
      },
      child: BlocBuilder<DashboardCubit, DashboardState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                AppStrings.tasks,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(48),
                child: TaskTabBar(
                  controller: _tabController,
                  tabs: cubit.state.tabList,
                  onCreateNewList: () => router.push(CreateListRoute()),
                ),
              ),
            ),
            body: TabBarView(
              controller: _tabController,
              children: [
                StarredListView(
                  tasks: state.starredList,
                  onSortPressed: () async {
                    final action = await _openSortOptionSheet(
                      context,
                      state.sortAction,
                    );

                    if (action == null) return;

                    cubit.onSortChanged(action);
                  },
                  onTaskTap: (t) => router.push(
                    TaskDetailRoute(task: t, taskGroupList: state.tabList),
                  ),
                  onTaskCheckChanged: cubit.onTaskCheckChange,
                  onTaskStarToggle: cubit.onTaskStarToggle,
                  onSubtaskTap: (t) => router.push(
                    TaskDetailRoute(task: t, taskGroupList: state.tabList),
                  ),
                  onSubtaskCheckChanged: cubit.onTaskCheckChange,
                  onSubtaskStarToggle: cubit.onTaskStarToggle,
                ),

                for (var tab in state.tabList)
                  TaskListView(
                    taskTab: tab,
                    tasks: cubit.getTasksForTab(tab.id),
                    onMorePressed: () async {
                      final action = await _openListActionSheet(
                        context,
                        tab.id != 1,
                        cubit.getCompletedTasksForTab(tab.id).isNotEmpty,
                      );

                      if (action == null) return;

                      switch (action) {
                        case ListAction.rename:
                          router.push(CreateListRoute(tab: tab));
                        case ListAction.delete:
                          cubit.deleteTab(tab.id);
                        case ListAction.deleteCompleted:
                          cubit.deleteCompletedTasks(tab.id);
                      }
                    },
                    onSortPressed: () async {
                      final action = await _openSortOptionSheet(
                        context,
                        state.sortAction,
                      );

                      if (action == null) return;

                      cubit.onSortChanged(action);
                    },
                    onTaskTap: (t) => router.push(
                      TaskDetailRoute(task: t, taskGroupList: state.tabList),
                    ),
                    onTaskCheckChanged: cubit.onTaskCheckChange,
                    onTaskStarToggle: cubit.onTaskStarToggle,
                    onSubtaskTap: (t) => router.push(
                      TaskDetailRoute(task: t, taskGroupList: state.tabList),
                    ),
                    onSubtaskCheckChanged: cubit.onTaskCheckChange,
                    onSubtaskStarToggle: cubit.onTaskStarToggle,
                  ),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () =>
                  _openNewTaskSheet(context, cubit.getCurrentTab().id),
              child: Icon(Icons.add),
            ),
          );
        },
      ),
    );
  }
}
