import 'package:flutter/material.dart';

import '../../../../presentation/core/resources/app_strings.dart';

enum SortAction { myOrder, date, deadline, starredRecently, title }

class SortActionSheet extends StatelessWidget {
  const SortActionSheet({super.key, required this.currentSelection});

  final SortAction currentSelection;

  Widget _buildCheckIcon(SortAction action) {
    return currentSelection == action
        ? const Icon(Icons.check)
        : const SizedBox(width: 24, height: 24);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Text(
              AppStrings.sortBy,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
            ),
          ),
          ListTile(
            leading: _buildCheckIcon(SortAction.myOrder),
            title: const Text(AppStrings.myOrder),
            onTap: () => Navigator.pop(context, SortAction.myOrder),
          ),
          ListTile(
            leading: _buildCheckIcon(SortAction.date),
            title: const Text(AppStrings.date),
            onTap: () => Navigator.pop(context, SortAction.date),
          ),
          ListTile(
            leading: _buildCheckIcon(SortAction.deadline),
            title: const Text(AppStrings.deadline),
            onTap: () => Navigator.pop(context, SortAction.deadline),
          ),
          ListTile(
            leading: _buildCheckIcon(SortAction.starredRecently),
            title: const Text(AppStrings.starredRecently),
            onTap: () => Navigator.pop(context, SortAction.starredRecently),
          ),
          ListTile(
            leading: _buildCheckIcon(SortAction.title),
            title: const Text(AppStrings.title),
            onTap: () => Navigator.pop(context, SortAction.title),
          ),
        ],
      ),
    );
  }
}
