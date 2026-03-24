import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_tasks_clone/domain/usecases/tasks/delete_task_usecase.dart';
import 'package:google_tasks_clone/domain/usecases/tasks/update_task_usecase.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain/entities/task_entity.dart';

@Injectable()
class TaskDetailCubit extends Cubit<TaskEntity> {
  TaskDetailCubit(
    @factoryParam super.initialState,
    this._updateTaskUsecase,
    this._deleteTaskUsecase,
  );

  final UpdateTaskUsecase _updateTaskUsecase;
  final DeleteTaskUsecase _deleteTaskUsecase;

  void onToggleFavorite() =>
      emit(state.copyWith(isFavorite: !state.isFavorite));

  void onTaskGroupChanged(int id) => emit(state.copyWith(taskGroupId: id));

  void onTitleChanged(String value) => emit(state.copyWith(title: value));

  void onDescChanged(String value) => emit(state.copyWith(description: value));

  void onDeadlineChanged(DateTime? value) =>
      emit(state.copyWith(deadline: (true, value)));

  void onDateTimeChanged(DateTime? value) =>
      emit(state.copyWith(dateTime: (true, value)));

  void onToggleCompleted() =>
      emit(state.copyWith(isCompleted: !state.isCompleted));

  void onAddSubtask() {
    final subtask = TaskEntity(
      taskGroupId: state.taskGroupId,
      parentTaskId: state.id!,
      title: '',
      createdAt: DateTime.now(),
      isSubtask: true,
    );
    emit(state.copyWith(subtasks: [...state.subtasks, subtask]));
  }

  void onSubtaskTitleChange(TaskEntity subtask, String title) {
    final updatedSubtasks = state.subtasks
        .map((s) => s == subtask ? subtask.copyWith(title: title) : s)
        .toList();
    emit(state.copyWith(subtasks: updatedSubtasks));
  }

  void onCompleteSubtask(TaskEntity subtask) {
    final updatedSubtasks = state.subtasks
        .map((s) => s == subtask ? s.copyWith(isCompleted: !s.isCompleted) : s)
        .toList();

    emit(state.copyWith(subtasks: updatedSubtasks));
  }

  void onDismissSubtask(TaskEntity subtask) {
    final updatedSubtasks = state.subtasks.where((s) => s != subtask).toList();
    emit(state.copyWith(subtasks: updatedSubtasks));
    deleteTask(subtask);
  }

  Future<void> saveChanges() async => _updateTaskUsecase.run(state);

  Future<void> deleteTask(TaskEntity task) async =>
      await _deleteTaskUsecase.run([task]);
}
