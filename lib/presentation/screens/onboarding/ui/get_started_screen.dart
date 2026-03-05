import 'package:flutter/material.dart';
import 'package:google_tasks_clone/resources/app_images.dart';
import 'package:google_tasks_clone/resources/app_strings.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({super.key, required this.onGetStarted});

  final VoidCallback onGetStarted;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: .center,
        children: [
          Image.asset(
            AppImages.imgNotification,
            width: 300,
            fit: BoxFit.fitWidth,
          ),

          Text(
            AppStrings.dontMissAThing,
            style: Theme.of(context).textTheme.headlineSmall,
          ),

          const SizedBox(height: 16),

          Text(
            AppStrings.addDateOrTime,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge,
          ),

          const SizedBox(height: 16),

          Text(
            AppStrings.additionalPermission,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall,
          ),

          const SizedBox(height: 16),

          FilledButton(
            onPressed: onGetStarted,
            style: FilledButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
            ),
            child: const Text(AppStrings.gotIt),
          ),
        ],
      ),
    );
  }
}
