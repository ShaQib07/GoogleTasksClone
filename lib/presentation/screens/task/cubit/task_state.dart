import 'package:freezed_annotation/freezed_annotation.dart';

part 'task_state.freezed.dart';

@freezed
abstract class TaskState with _$TaskState {
  const TaskState._();

  const factory TaskState({
    required String title,
    required String? description,
    required bool isDescriptionEnabled,
    required String? deadline,
    required String? reminder,
    required bool isFavorite,
    required bool isCompleted,
  }) = _TaskState;

  factory TaskState.initial() {
    return TaskState(title: '', description: '', isDescriptionEnabled: false, deadline: '', reminder: '', isFavorite: false, isCompleted: false);
  }
}
