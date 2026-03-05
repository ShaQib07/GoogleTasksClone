import 'package:flutter/material.dart';
import 'package:google_tasks_clone/domain/entities/task_tab_entity.dart';

import '../../../../../resources/app_strings.dart';

class TabToolbar extends StatelessWidget {
  const TabToolbar({
    super.key,
    required this.tab,
    this.onMorePressed,
    required this.onSortPressed,
  });

  final TaskTabEntity tab;
  final VoidCallback? onMorePressed;
  final VoidCallback onSortPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          tab.tabName,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),

        const Spacer(),

        IconButton(
          onPressed: onSortPressed,
          icon: const Icon(Icons.sort_sharp),
        ),

        if (tab.tabName != AppStrings.starred)
          IconButton(
            onPressed: onMorePressed,
            icon: const Icon(Icons.more_vert),
          ),
      ],
    );
  }
}
