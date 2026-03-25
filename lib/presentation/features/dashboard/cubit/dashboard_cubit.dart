import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_tasks_clone/domain/entities/task_entity.dart';
import 'package:google_tasks_clone/domain/entities/task_group_entity.dart';
import 'package:google_tasks_clone/domain/usecases/task_groups/delete_task_group_usecase.dart';
import 'package:google_tasks_clone/domain/usecases/task_groups/read_task_group_usecase.dart';
import 'package:google_tasks_clone/domain/usecases/tasks/delete_task_usecase.dart';
import 'package:google_tasks_clone/domain/usecases/tasks/get_starred_task_usecase.dart';
import 'package:google_tasks_clone/domain/usecases/tasks/read_task_usecase.dart';
import 'package:google_tasks_clone/presentation/features/dashboard/cubit/dashboard_state.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain/usecases/tasks/update_task_usecase.dart';
import '../ui/sort_action_sheet.dart';

@Injectable()
class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit(
    this._readTaskGroupUsecase,
    this._deleteTaskGroupUsecase,
    this._readTaskUsecase,
    this._getStarredTaskUsecase,
    this._updateTaskUsecase,
    this._deleteTaskUsecase,
  ) : super(DashboardState.initial()) {
    _listenTaskGroups();
    _listenTasks();
  }

  final ReadTaskGroupUsecase _readTaskGroupUsecase;
  final DeleteTaskGroupUsecase _deleteTaskGroupUsecase;
  final ReadTaskUsecase _readTaskUsecase;
  final GetStarredTaskUsecase _getStarredTaskUsecase;
  final UpdateTaskUsecase _updateTaskUsecase;
  final DeleteTaskUsecase _deleteTaskUsecase;

  StreamSubscription? _tabSubscription;
  StreamSubscription? _taskSubscription;
  StreamSubscription? _starredTaskSubscription;

  void _listenTaskGroups() {
    _tabSubscription = _readTaskGroupUsecase.run().listen((tabs) {
      emit(state.copyWith(tabList: tabs, selectedTab: tabs.length));
    });
  }

  List<TaskEntity> getTasksForTab(int? tabId) {
    final tasks = state.taskList.where((t) => t.taskGroupId == tabId).toList();
    return _getSortedTasks(tasks);
  }

  List<TaskEntity> getCompletedTasksForTab(int? tabId) => state.taskList
      .where((t) => t.taskGroupId == tabId && t.isCompleted)
      .toList();

  TaskGroupEntity getCurrentTab() => state.tabList[state.selectedTab - 1];

  Future<void> deleteTab(int? tabId) async =>
      await _deleteTaskGroupUsecase.run(tabId ?? 0);

  void onTabChanged(int index) => emit(state.copyWith(selectedTab: index));

  void _listenTasks() {
    _taskSubscription = _readTaskUsecase.run().listen((tasks) {
      emit(state.copyWith(taskList: tasks));
    });

    _starredTaskSubscription = _getStarredTaskUsecase.run().listen((tasks) {
      emit(state.copyWith(starredList: tasks));
    });
  }

  Future<void> _updateTask(TaskEntity task) async =>
      await _updateTaskUsecase.run(task);

  Future<void> deleteCompletedTasks(int? tabId) async =>
      await _deleteTaskUsecase.run(getCompletedTasksForTab(tabId));

  void onTaskCheckChange(TaskEntity task) =>
      _updateTask(task.copyWith(isCompleted: !task.isCompleted));

  void onTaskStarToggle(TaskEntity task) =>
      _updateTask(task.copyWith(isFavorite: !task.isFavorite));

  void onSortChanged(SortAction action) {
    emit(state.copyWith(sortAction: action));
    emit(state.copyWith(taskList: _getSortedTasks(state.taskList)));
  }

  List<TaskEntity> _getSortedTasks(List<TaskEntity> tasks) {
    final sortedList = List.of(tasks);

    int Function(TaskEntity a, TaskEntity b) comparator;

    switch (state.sortAction) {
      case SortAction.myOrder:
        comparator = (a, b) => a.createdAt.compareTo(b.createdAt);

      case SortAction.date:
        comparator = (a, b) {
          final aDate = a.dateTime;
          final bDate = b.dateTime;

          if (aDate == null && bDate == null) return 0;
          if (aDate == null) return 1;
          if (bDate == null) return -1;

          return aDate.compareTo(bDate);
        };

      case SortAction.deadline:
        comparator = (a, b) {
          final aDeadline = a.deadline;
          final bDeadline = b.deadline;

          if (aDeadline == null && bDeadline == null) return 0;
          if (aDeadline == null) return 1;
          if (bDeadline == null) return -1;

          return aDeadline.compareTo(bDeadline);
        };

      case SortAction.starredRecently:
        comparator = (a, b) =>
            (b.isFavorite ? 1 : 0).compareTo(a.isFavorite ? 1 : 0);

      case SortAction.title:
        comparator = (a, b) => a.title.compareTo(b.title);
    }

    sortedList.sort(comparator);

    return sortedList;
  }

  @override
  Future<void> close() {
    _tabSubscription?.cancel();
    _taskSubscription?.cancel();
    _starredTaskSubscription?.cancel();
    return super.close();
  }
}
