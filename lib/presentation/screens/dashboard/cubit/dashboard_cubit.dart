import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_tasks_clone/domain/entities/task_entity.dart';
import 'package:google_tasks_clone/domain/entities/task_tab_entity.dart';
import 'package:google_tasks_clone/domain/usecases/tasks/delete_task_usecase.dart';
import 'package:google_tasks_clone/domain/usecases/tasks/read_task_usecase.dart';
import 'package:google_tasks_clone/presentation/screens/dashboard/cubit/dashboard_state.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain/usecases/tabs/delete_tab_usecase.dart';
import '../../../../domain/usecases/tabs/read_tab_usecase.dart';
import '../../../../domain/usecases/tasks/update_task_usecase.dart';
import '../ui/sort_action_sheet.dart';

@Injectable()
class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit(
    this._readTabUsecase,
    this._deleteTabUsecase,
    this._readTaskUsecase,
    this._updateTaskUsecase,
    this._deleteTaskUsecase,
  ) : super(DashboardState.initial()) {
    _listenTabs();
    _listenTasks();
  }

  final ReadTabUsecase _readTabUsecase;
  final DeleteTabUsecase _deleteTabUsecase;
  final ReadTaskUsecase _readTaskUsecase;
  final UpdateTaskUsecase _updateTaskUsecase;
  final DeleteTaskUsecase _deleteTaskUsecase;

  StreamSubscription? _tabSubscription;
  StreamSubscription? _taskSubscription;

  void _listenTabs() {
    _tabSubscription = _readTabUsecase.run().listen((tabs) {
      emit(state.copyWith(tabList: tabs, selectedTab: tabs.length));
    });
  }

  List<TaskEntity> getTasksForTab(int? tabId) =>
      state.taskList.where((t) => t.tabId == tabId).toList();

  List<TaskEntity> getCompletedTasksForTab(int? tabId) =>
      state.taskList.where((t) => t.tabId == tabId && t.isCompleted).toList();

  TaskTabEntity getCurrentTab() => state.tabList[state.selectedTab - 1];

  Future<void> deleteTab(int? tabId) async =>
      await _deleteTabUsecase.run(tabId ?? 0);

  void onTabChanged(int index) => emit(state.copyWith(selectedTab: index));

  void _listenTasks() {
    _taskSubscription = _readTaskUsecase.run().listen((tasks) {
      emit(state.copyWith(taskList: tasks));
    });
  }

  List<TaskEntity> getStarredTasks() =>
      state.taskList.where((t) => t.isFavorite).toList();

  Future<void> _updateTask(TaskEntity task) async =>
      await _updateTaskUsecase.run(task);

  Future<void> deleteCompletedTasks(int? tabId) async =>
      await _deleteTaskUsecase.run(getCompletedTasksForTab(tabId));

  void onTaskChecked(TaskEntity task, bool value) =>
      _updateTask(task.copyWith(isCompleted: value));

  void onTaskStarred(TaskEntity task, bool value) =>
      _updateTask(task.copyWith(isFavorite: value));

  void onSortChanged(SortAction action) =>
      emit(state.copyWith(sortAction: action));

  @override
  Future<void> close() {
    _tabSubscription?.cancel();
    _taskSubscription?.cancel();
    return super.close();
  }
}
