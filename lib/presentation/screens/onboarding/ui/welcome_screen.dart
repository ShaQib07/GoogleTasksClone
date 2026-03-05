import 'package:flutter/material.dart';
import 'package:google_tasks_clone/resources/app_images.dart';
import 'package:google_tasks_clone/resources/app_strings.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: .center,
        children: [
          Image.asset(
            AppImages.imgWelcome,
            width: 300,
            fit: BoxFit.fitWidth,
          ),

          Text(
            AppStrings.welcomeToTasks,
            style: Theme.of(context).textTheme.headlineSmall,
          ),

          const SizedBox(height: 20),

          Text(
            AppStrings.keepTrackOfImportantThings,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }
}
