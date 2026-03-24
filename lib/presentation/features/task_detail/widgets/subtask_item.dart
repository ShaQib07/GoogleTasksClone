import 'package:flutter/material.dart';

import '../../../../domain/entities/task_entity.dart';
import '../../../core/resources/app_strings.dart';

class SubtaskItem extends StatefulWidget {
  const SubtaskItem({
    super.key,
    required this.subtask,
    required this.onTitleChange,
    required this.onCheckChanged,
    required this.onDismiss,
  });

  final TaskEntity subtask;
  final Function(String title) onTitleChange;
  final VoidCallback onCheckChanged;
  final VoidCallback onDismiss;

  @override
  State<StatefulWidget> createState() => _SubtaskItemState();
}

class _SubtaskItemState extends State<SubtaskItem> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.subtask.title);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
        children: [
          Checkbox(
            visualDensity: .compact,
            shape: const CircleBorder(),
            value: widget.subtask.isCompleted,
            onChanged: (_) => widget.onCheckChanged(),
          ),

          Expanded(
            child: TextField(
              style: const TextStyle(fontSize: 15),
              controller: _controller,
              onChanged: widget.onTitleChange,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: AppStrings.enterTitle,
                isDense: true,
                contentPadding: .only(top: 14),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.close, size: 18),
                  onPressed: widget.onDismiss,
                ),
              ),
            ),
          ),
        ],
    );
  }
}
