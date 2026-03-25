import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_tasks_clone/domain/entities/task_entity.dart';
import 'package:google_tasks_clone/domain/entities/task_group_entity.dart';
import 'package:google_tasks_clone/presentation/features/dashboard/ui/sort_action_sheet.dart';

part 'dashboard_state.freezed.dart';

@freezed
abstract class DashboardState with _$DashboardState {
  const DashboardState._();

  const factory DashboardState({
    required List<TaskGroupEntity> tabList,
    required int selectedTab,
    required List<TaskEntity> taskList,
    required List<TaskEntity> starredList,
    required SortAction sortAction,
  }) = _DashboardState;

  factory DashboardState.initial() {
    return DashboardState(
      tabList: [],
      selectedTab: 0,
      taskList: [],
      starredList: [],
      sortAction: SortAction.myOrder,
    );
  }
}
