import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_tasks_clone/domain/entities/task_tab_entity.dart';
import 'package:google_tasks_clone/domain/usecases/tabs/create_tab_usecase.dart';
import 'package:google_tasks_clone/domain/usecases/tabs/update_tab_usecase.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class CreateListCubit extends Cubit<String> {
  CreateListCubit(this._createTabUsecase, this._updateTabUsecase) : super("");

  final CreateTabUsecase _createTabUsecase;
  final UpdateTabUsecase _updateTabUsecase;

  void onTitleChanged(String value) => emit(value);

  Future<void> createOrUpdateTab(TaskTabEntity? tab) async {
    if (tab == null) {
      await _createTabUsecase.run(TaskTabEntity(tabName: state));
    } else {
      await _updateTabUsecase.run(TaskTabEntity(id: tab.id, tabName: state));
    }
  }
}
