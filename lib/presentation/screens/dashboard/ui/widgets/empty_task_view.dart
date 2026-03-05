import 'package:flutter/material.dart';
import 'package:google_tasks_clone/domain/entities/task_tab_entity.dart';
import 'package:google_tasks_clone/presentation/screens/dashboard/ui/widgets/tab_toolbar.dart';
import 'package:google_tasks_clone/resources/app_images.dart';

class EmptyTaskView extends StatelessWidget {
  const EmptyTaskView({
    super.key,
    required this.tab,
    required this.primaryText,
    required this.secondaryText,
    this.onMorePressed,
    required this.onSortPressed,
  });

  final TaskTabEntity tab;
  final String primaryText;
  final String secondaryText;
  final VoidCallback? onMorePressed;
  final VoidCallback onSortPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          margin: EdgeInsetsGeometry.all(8),
          child: Container(
            padding: const EdgeInsets.fromLTRB(24, 6, 6, 16),
            child: Column(
              children: [
                TabToolbar(
                  tab: tab,
                  onMorePressed: onMorePressed,
                  onSortPressed: onSortPressed,
                ),

                const SizedBox(height: 8),

                Image.asset(
                  AppImages.imgNoData,
                  width: 300,
                  fit: BoxFit.fitWidth,
                ),

                Text(
                  primaryText,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),

                const SizedBox(height: 8),

                Text(secondaryText, textAlign: TextAlign.center),

                const SizedBox(height: 8),
              ],
            ),
          ),
        ),

        // Fills all remaining space
        Expanded(child: Container()),
      ],
    );
  }
}
