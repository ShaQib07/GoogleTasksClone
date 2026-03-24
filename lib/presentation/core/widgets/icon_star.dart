import 'package:flutter/material.dart';

class IconStar extends StatelessWidget {
  const IconStar({
    super.key,
    required this.isStarred,
    required this.onStarToggle,
  });

  final bool isStarred;
  final VoidCallback onStarToggle;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onStarToggle,
      icon: isStarred
          ? Icon(Icons.star, color: Theme.of(context).colorScheme.primary)
          : const Icon(Icons.star_border),
    );
  }
}
