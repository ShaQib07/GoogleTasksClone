import 'package:flutter/material.dart';

import '../../../../presentation/core/resources/app_strings.dart';

enum ListAction { rename, delete, deleteCompleted }

class ListActionSheet extends StatelessWidget {
  const ListActionSheet({super.key, required this.hasCompletedTasks});

  final bool hasCompletedTasks;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: const Text(AppStrings.renameList),
            onTap: () => Navigator.pop(context, ListAction.rename),
          ),
          ListTile(
            title: const Text(AppStrings.deleteList),
            onTap: () => Navigator.pop(context, ListAction.delete),
          ),
          ListTile(
            enabled: hasCompletedTasks,
            title: const Text(AppStrings.deleteCompletedTasks),
            onTap: () => Navigator.pop(context, ListAction.deleteCompleted),
          ),
        ],
      ),
    );
  }
}
