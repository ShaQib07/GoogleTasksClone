import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_tasks_clone/domain/usecases/onboarding/finish_onboarding_usecase.dart';
import 'package:google_tasks_clone/domain/usecases/task_groups/create_task_group_usecase.dart';
import 'package:google_tasks_clone/presentation/features/onboarding/cubit/onboarding_state.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain/entities/task_group_entity.dart';
import '../../../../domain/usecases/onboarding/check_onboarding_usecase.dart';
import '../../../core/resources/app_strings.dart';

@Injectable()
class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit(
    this._finishOnboardingUsecase,
    this._checkOnboardingUsecase,
    this._createTaskGroupUsecase,
  ) : super(OnboardingState.initial()) {
    _checkOnboarding();
  }

  final FinishOnboardingUsecase _finishOnboardingUsecase;
  final CheckOnboardingUsecase _checkOnboardingUsecase;
  final CreateTaskGroupUsecase _createTaskGroupUsecase;

  final int totalPages = 2;

  void onPageChanged(int index) => emit(
    state.copyWith(currentPage: index, isLastPage: index == totalPages - 1),
  );

  Future<void> _checkOnboarding() async {
    bool hasOnboarded = await _checkOnboardingUsecase.run() ?? false;
    if (hasOnboarded) {
      emit(state.copyWith(shouldNavigateToDashboard: true));
    }
  }

  Future<void> finishOnboarding() async {
    await _createTaskGroupUsecase.run(
      const TaskGroupEntity(title: AppStrings.myTasks),
    );
    await _finishOnboardingUsecase.run();
    emit(state.copyWith(shouldNavigateToDashboard: true));
  }
}
