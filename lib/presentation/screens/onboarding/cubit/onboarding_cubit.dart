import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_tasks_clone/domain/usecases/onboarding/finish_onboarding_usecase.dart';
import 'package:google_tasks_clone/domain/usecases/tabs/create_tab_usecase.dart';
import 'package:google_tasks_clone/presentation/screens/onboarding/cubit/onboarding_state.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain/entities/task_tab_entity.dart';
import '../../../../domain/usecases/onboarding/check_onboarding_usecase.dart';
import '../../../../resources/app_strings.dart';

@Injectable()
class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit(
    this._finishOnboardingUsecase,
    this._checkOnboardingUsecase,
    this._createTabUsecase,
  ) : super(OnboardingState.initial()) {
    _checkOnboarding();
  }

  final FinishOnboardingUsecase _finishOnboardingUsecase;
  final CheckOnboardingUsecase _checkOnboardingUsecase;
  final CreateTabUsecase _createTabUsecase;

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
    await _createTabUsecase.run(
      const TaskTabEntity(tabName: AppStrings.myTasks),
    );
    await _finishOnboardingUsecase.run();
    emit(state.copyWith(shouldNavigateToDashboard: true));
  }
}
