import 'package:flutter/material.dart';

class DismissibleChip extends StatelessWidget {
  const DismissibleChip({
    super.key,
    required this.label,
    required this.onDismiss,
    this.onPress,
  });

  final String label;
  final VoidCallback onDismiss;
  final VoidCallback? onPress;

  @override
  Widget build(BuildContext context) {
    return InputChip(
      label: Text(
        label,
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
      visualDensity: VisualDensity.comfortable,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      backgroundColor: Theme.of(context).colorScheme.surface,
      side: BorderSide(
        color: Theme.of(context).textTheme.bodyMedium!.color!,
        width: 0.7,
      ),
      onDeleted: onDismiss,
      onPressed: onPress,
    );
  }
}
