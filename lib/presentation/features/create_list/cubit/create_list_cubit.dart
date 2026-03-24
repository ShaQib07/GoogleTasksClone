import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_tasks_clone/domain/entities/task_group_entity.dart';
import 'package:google_tasks_clone/domain/usecases/task_groups/create_task_group_usecase.dart';
import 'package:google_tasks_clone/domain/usecases/task_groups/update_task_group_usecase.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class CreateListCubit extends Cubit<String> {
  CreateListCubit(this._createTaskGroupUsecase, this._updateTaskGroupUsecase)
    : super('');

  final CreateTaskGroupUsecase _createTaskGroupUsecase;
  final UpdateTaskGroupUsecase _updateTaskGroupUsecase;

  void onTitleChanged(String value) => emit(value);

  Future<void> createOrUpdateTab(TaskGroupEntity? tab) async {
    if (tab == null) {
      await _createTaskGroupUsecase.run(TaskGroupEntity(title: state));
    } else {
      await _updateTaskGroupUsecase.run(TaskGroupEntity(id: tab.id, title: state));
    }
  }
}
