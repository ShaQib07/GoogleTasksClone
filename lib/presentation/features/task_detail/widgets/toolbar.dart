import 'package:flutter/material.dart';

import '../../../core/widgets/icon_star.dart';

class Toolbar extends StatelessWidget {
  const Toolbar({
    super.key,
    required this.isStarred,
    required this.onBack,
    required this.onStarToggle,
  });

  final bool isStarred;
  final VoidCallback onBack;
  final VoidCallback onStarToggle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: .symmetric(horizontal: 4, vertical: 8),
      child: Row(
        children: [
          IconButton(onPressed: onBack, icon: Icon(Icons.arrow_back)),

          Spacer(),

          IconStar(isStarred: isStarred, onStarToggle: onStarToggle),

          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
        ],
      ),
    );
  }
}
