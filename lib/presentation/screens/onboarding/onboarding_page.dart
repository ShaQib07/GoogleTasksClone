import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_tasks_clone/di/injection.dart';
import 'package:google_tasks_clone/presentation/screens/onboarding/cubit/onboarding_cubit.dart';
import 'package:google_tasks_clone/presentation/screens/onboarding/ui/onboarding_body.dart';

@RoutePage()
class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OnboardingCubit>(
      create: (context) => injector(),
      child: const OnboardingBody(),
    );
  }
}
