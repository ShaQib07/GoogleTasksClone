import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_tasks_clone/presentation/features/onboarding/cubit/onboarding_cubit.dart';
import 'package:google_tasks_clone/presentation/features/onboarding/ui/get_started_screen.dart';
import 'package:google_tasks_clone/presentation/features/onboarding/ui/welcome_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../core/routes/router.gr.dart';
import '../cubit/onboarding_state.dart';

class OnboardingBody extends StatefulWidget {
  const OnboardingBody({super.key});

  @override
  State<OnboardingBody> createState() => _OnboardingBodyState();
}

class _OnboardingBodyState extends State<OnboardingBody> {
  final PageController _controller = PageController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final router = context.router;
    final cubit = context.read<OnboardingCubit>();

    return BlocListener<OnboardingCubit, OnboardingState>(
      listener: (context, state) {
        if (state.shouldNavigateToDashboard) {
          router.replace(const DashboardRoute());
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              // PageView
              Expanded(
                child: PageView(
                  controller: _controller,
                  onPageChanged: cubit.onPageChanged,
                  children: [
                    const WelcomeScreen(),
                    GetStartedScreen(onGetStarted: cubit.finishOnboarding),
                  ],
                ),
              ),

              // Dot indicator
              BlocBuilder<OnboardingCubit, OnboardingState>(
                builder: (context, state) {
                  return Container(
                    padding: const EdgeInsets.all(8),
                    child: Stack(
                      alignment: Alignment.center,
                      clipBehavior: Clip.none,
                      children: [
                        // Dots
                        Center(
                          child: SmoothPageIndicator(
                            controller: _controller,
                            count: cubit.totalPages,
                            effect: JumpingDotEffect(
                              dotHeight: 8,
                              dotWidth: 8,
                              dotColor: Theme.of(context).colorScheme.outline,
                              activeDotColor: Theme.of(
                                context,
                              ).colorScheme.primary,
                            ),
                          ),
                        ),

                        if (!state.isLastPage)
                          Positioned(
                            right: 0,
                            child: IconButton(
                              icon: const Icon(Icons.arrow_forward_ios),
                              iconSize: 20,
                              onPressed: () {
                                _controller.nextPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.ease,
                                );
                              },
                            ),
                          ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
