import 'package:freezed_annotation/freezed_annotation.dart';

part 'onboarding_state.freezed.dart';

@freezed
abstract class OnboardingState with _$OnboardingState {
  const OnboardingState._();

  const factory OnboardingState({
    required int currentPage,
    required bool isLastPage,
    required bool shouldNavigateToDashboard,
  }) = _OnboardingState;

  factory OnboardingState.initial() {
    return OnboardingState(
      currentPage: 0,
      isLastPage: false,
      shouldNavigateToDashboard: false,
    );
  }
}
