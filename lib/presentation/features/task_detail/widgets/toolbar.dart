import 'package:flutter/material.dart';
import 'package:google_tasks_clone/presentation/core/resources/app_strings.dart';

import '../../../core/widgets/icon_star.dart';

class Toolbar extends StatelessWidget {
  const Toolbar({
    super.key,
    required this.isStarred,
    required this.onBack,
    required this.onStarToggle,
    required this.onDelete,
  });

  final bool isStarred;
  final VoidCallback onBack;
  final VoidCallback onStarToggle;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: .symmetric(horizontal: 4, vertical: 8),
      child: Row(
        children: [
          IconButton(onPressed: onBack, icon: Icon(Icons.arrow_back)),

          Spacer(),

          IconStar(isStarred: isStarred, onStarToggle: onStarToggle),

          PopupMenuButton<String>(
            onSelected: (_) => onDelete(),
            itemBuilder: (context) => [
              PopupMenuItem(
                value: AppStrings.delete,
                child: SizedBox(
                  width: 140,
                  child: const Text(AppStrings.delete),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
