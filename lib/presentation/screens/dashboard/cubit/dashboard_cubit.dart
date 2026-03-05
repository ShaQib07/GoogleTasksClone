import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_tasks_clone/domain/entities/task_entity.dart';
import 'package:google_tasks_clone/domain/usecases/tasks/read_task_usecase.dart';
import 'package:google_tasks_clone/presentation/screens/dashboard/cubit/dashboard_state.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain/usecases/tabs/delete_tab_usecase.dart';
import '../../../../domain/usecases/tabs/read_tab_usecase.dart';

@Injectable()
class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit(
    this._readTabUsecase,
    this._readTaskUsecase,
    this._deleteTabUsecase,
  ) : super(DashboardState.initial()) {
    _listenTabs();
    _listenTasks();
  }
  final ReadTabUsecase _readTabUsecase;
  final ReadTaskUsecase _readTaskUsecase;
  final DeleteTabUsecase _deleteTabUsecase;

  StreamSubscription? _tabSubscription;
  StreamSubscription? _taskSubscription;

  void _listenTabs() {
    _tabSubscription = _readTabUsecase.run().listen((tabs) {
      emit(state.copyWith(tabList: tabs, selectedTab: tabs.length));
    });
  }

  void _listenTasks() {
    _taskSubscription = _readTaskUsecase.run().listen((tasks) {
      emit(state.copyWith(taskList: tasks));
    });
  }

  List<TaskEntity> getTasksForTab(int? tabId) =>
      state.taskList.where((t) => t.tabId == tabId).toList();

  List<TaskEntity> getStarredTasks() =>
      state.taskList.where((t) => t.isFavorite).toList();

  Future<void> deleteTab(int? tabId) async =>
      await _deleteTabUsecase.run(tabId ?? 0);

  void selectTab(int index) => emit(state.copyWith(selectedTab: index));

  @override
  Future<void> close() {
    _tabSubscription?.cancel();
    _taskSubscription?.cancel();
    return super.close();
  }
}
