import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_tasks_clone/domain/entities/task_entity.dart';
import 'package:google_tasks_clone/domain/entities/task_tab_entity.dart';

part 'dashboard_state.freezed.dart';

@freezed
abstract class DashboardState with _$DashboardState {
  const DashboardState._();

  const factory DashboardState({
    required List<TaskTabEntity> tabList,
    required int selectedTab,
    required List<TaskEntity> taskList,
  }) = _DashboardState;

  factory DashboardState.initial() {
    return DashboardState(tabList: [], selectedTab: 0, taskList: []);
  }
}
