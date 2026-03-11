import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_tasks_clone/domain/entities/task_entity.dart';
import 'package:google_tasks_clone/domain/usecases/tasks/create_task_usecase.dart';
import 'package:google_tasks_clone/presentation/screens/task/cubit/task_state.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class TaskCubit extends Cubit<TaskState> {
  TaskCubit(this._createTaskUsecase) : super(TaskState.initial());

  final CreateTaskUsecase _createTaskUsecase;

  void onTitleChanged(String value) => emit(state.copyWith(title: value));

  void onDescChanged(String value) => emit(state.copyWith(description: value));

  void enableDescription() => emit(state.copyWith(isDescriptionEnabled: true));

  void toggleFavorite() => emit(state.copyWith(isFavorite: !state.isFavorite));

  void onDateTimeChanged(DateTime value) => emit(state.copyWith(dateTime: value));

  void onDismissDateTime() => emit(state.copyWith(dateTime: null));

  Future<void> createTask(int? tabId) async {
    await _createTaskUsecase.run(
      TaskEntity(
        tabId: tabId ?? 0,
        title: state.title,
        description: state.description,
        dateTime: state.dateTime,
        deadline: state.deadline,
        reminder: state.reminder,
        isFavorite: state.isFavorite,
        isCompleted: false,
        createdAt: DateTime.now(),
      ),
    );
  }
}
