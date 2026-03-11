import 'package:freezed_annotation/freezed_annotation.dart';

part 'task_state.freezed.dart';

@freezed
abstract class TaskState with _$TaskState {
  const TaskState._();

  const factory TaskState({
    required String title,
    required String? description,
    required bool isDescriptionEnabled,
    required DateTime? dateTime,
    required DateTime? deadline,
    required String? reminder,
    required bool isFavorite,
    required bool isCompleted,
    required DateTime createdAt,
  }) = _TaskState;

  factory TaskState.initial() {
    return TaskState(
      title: '',
      description: '',
      isDescriptionEnabled: false,
      dateTime: null,
      deadline: null,
      reminder: '',
      isFavorite: false,
      isCompleted: false,
      createdAt: DateTime.now(),
    );
  }
}
