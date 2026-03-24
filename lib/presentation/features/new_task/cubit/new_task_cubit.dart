import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_tasks_clone/domain/entities/task_entity.dart';
import 'package:google_tasks_clone/domain/usecases/tasks/create_task_usecase.dart';
import 'package:google_tasks_clone/presentation/features/new_task/cubit/new_task_state.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class NewTaskCubit extends Cubit<NewTaskState> {
  NewTaskCubit(this._createTaskUsecase) : super(NewTaskState.initial());

  final CreateTaskUsecase _createTaskUsecase;

  void onTitleChanged(String value) => emit(state.copyWith(title: value));

  void onDescChanged(String value) => emit(state.copyWith(description: value));

  void enableDescription() => emit(state.copyWith(isDescriptionEnabled: true));

  void toggleFavorite() => emit(state.copyWith(isFavorite: !state.isFavorite));

  void onDateTimeChanged(DateTime? value) =>
      emit(state.copyWith(dateTime: value));

  Future<void> createTask(int? tabId) async {
    await _createTaskUsecase.run([
      TaskEntity(
        taskGroupId: tabId ?? 0,
        title: state.title,
        description: state.description,
        dateTime: state.dateTime,
        isFavorite: state.isFavorite,
        isCompleted: false,
        createdAt: DateTime.now(),
        isSubtask: false,
      ),
    ]);
  }
}
