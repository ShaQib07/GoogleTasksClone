import 'package:freezed_annotation/freezed_annotation.dart';

part 'new_task_state.freezed.dart';

@freezed
abstract class NewTaskState with _$NewTaskState {
  const NewTaskState._();

  const factory NewTaskState({
    required String title,
    required String? description,
    required bool isDescriptionEnabled,
    required DateTime? dateTime,
    required bool isFavorite,
    required bool isCompleted,
  }) = _NewTaskState;

  factory NewTaskState.initial() {
    return NewTaskState(
      title: '',
      description: '',
      isDescriptionEnabled: false,
      dateTime: null,
      isFavorite: false,
      isCompleted: false,
    );
  }
}
