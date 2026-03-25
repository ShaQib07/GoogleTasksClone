import 'package:flutter/material.dart';

import '../../../../presentation/core/resources/app_strings.dart';

enum ListAction { rename, delete, deleteCompleted }

class ListActionSheet extends StatelessWidget {
  const ListActionSheet({
    super.key,
    required this.isDeletable,
    required this.hasCompletedTasks,
  });

  final bool isDeletable;
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
            enabled: isDeletable,
            title: const Text(AppStrings.deleteList),
            subtitle: isDeletable ? null : const Text(AppStrings.cannotDelete),
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
