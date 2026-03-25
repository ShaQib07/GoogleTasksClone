import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_tasks_clone/core/extensions/date_time.dart';
import 'package:google_tasks_clone/presentation/features/task_detail/ui/task_group_selection_sheet.dart';

import '../../../../domain/entities/task_entity.dart';
import '../../../../domain/entities/task_group_entity.dart';
import '../../../core/resources/app_strings.dart';
import '../../../core/widgets/date_time_picker.dart';
import '../../../core/widgets/dismissible_chip.dart';
import '../cubit/task_detail_cubit.dart';
import '../widgets/subtask_view.dart';
import '../widgets/toolbar.dart';

class TaskDetailBody extends StatefulWidget {
  const TaskDetailBody({
    super.key,
    required this.task,
    required this.taskGroupList,
  });

  final TaskEntity task;
  final List<TaskGroupEntity> taskGroupList;

  @override
  State<StatefulWidget> createState() => _TaskDetailBodyState();
}

class _TaskDetailBodyState extends State<TaskDetailBody> {
  late final TextEditingController _titleController;
  late final TextEditingController _descController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.task.title);
    _descController = TextEditingController(text: widget.task.description);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  Future<int?> _openSortOptionSheet(
    BuildContext context,
    int currentTaskGroupId,
  ) => showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (_) => TaskGroupSelectionSheet(
      taskGroupList: widget.taskGroupList,
      currentTaskGroupId: currentTaskGroupId,
    ),
  );

  void _openDatePicker(BuildContext context) async {
    final cubit = context.read<TaskDetailCubit>();
    final deadline = await showDatePicker(
      context: context,
      initialDate: cubit.state.deadline ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (deadline != null) cubit.onDeadlineChanged(deadline);
  }

  void _openDateTimePicker(BuildContext context) async {
    final cubit = context.read<TaskDetailCubit>();
    final dateTime = await showDialog<DateTime>(
      context: context,
      builder: (_) => Dialog(
        insetPadding: const EdgeInsets.all(32),
        child: DateTimePicker(selectedDateTime: cubit.state.dateTime),
      ),
    );

    if (dateTime != null) cubit.onDateTimeChanged(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    final router = context.router;
    final cubit = context.read<TaskDetailCubit>();

    return PopScope(
      onPopInvokedWithResult: (_, _) => cubit.saveChanges(),
      child: BlocBuilder<TaskDetailCubit, TaskEntity>(
        builder: (context, state) {
          return Scaffold(
            body: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Card(
                      margin: .only(top: 4),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Column(
                        children: [
                          Toolbar(
                            isStarred: state.isFavorite,
                            onBack: router.pop,
                            onStarToggle: cubit.onToggleFavorite,
                            onDelete: () {
                              cubit.deleteTask(state);
                              router.pop();
                            },
                          ),

                          Expanded(
                            child: SingleChildScrollView(
                              padding: .only(left: 20, right: 20, bottom: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // TaskGroup
                                  InkWell(
                                    onTap: () async {
                                      final taskGroupId =
                                          await _openSortOptionSheet(
                                            context,
                                            state.taskGroupId,
                                          );

                                      if (taskGroupId == null) return;

                                      cubit.onTaskGroupChanged(taskGroupId);
                                    },
                                    child: Padding(
                                      padding: .symmetric(vertical: 12),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        spacing: 4,
                                        children: [
                                          Text(
                                            widget.taskGroupList
                                                .firstWhere(
                                                  (g) =>
                                                      g.id == state.taskGroupId,
                                                )
                                                .title,
                                            style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: .bold,
                                              color: Theme.of(
                                                context,
                                              ).colorScheme.primary,
                                            ),
                                          ),

                                          Icon(
                                            Icons.arrow_drop_down,
                                            size: 24,
                                            color: Theme.of(
                                              context,
                                            ).colorScheme.primary,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  // Title
                                  TextField(
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w600,
                                      decoration: state.isCompleted
                                          ? TextDecoration.lineThrough
                                          : null,
                                    ),
                                    controller: _titleController,
                                    onChanged: cubit.onTitleChanged,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: AppStrings.enterTitle,
                                    ),
                                  ),

                                  // Description
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    spacing: 16,
                                    children: [
                                      Padding(
                                        padding: .only(top: 8),
                                        child: Icon(Icons.notes),
                                      ),

                                      Expanded(
                                        child: TextField(
                                          style: const TextStyle(fontSize: 15),
                                          controller: _descController,
                                          onChanged: cubit.onDescChanged,
                                          maxLines: null,
                                          decoration: const InputDecoration(
                                            border: InputBorder.none,
                                            hintText: AppStrings.addDetails,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  // Deadline
                                  ListTile(
                                    contentPadding: .symmetric(horizontal: 2),
                                    leading: Icon(Icons.track_changes),
                                    title: Row(
                                      children: [
                                        state.deadline == null
                                            ? Text(
                                                AppStrings.addDeadline,
                                                style: const TextStyle(
                                                  fontSize: 15,
                                                ),
                                              )
                                            : DismissibleChip(
                                                label: state.deadline!
                                                    .formattedString(),
                                                onDismiss: () => cubit
                                                    .onDeadlineChanged(null),
                                              ),

                                        Spacer(),
                                      ],
                                    ),
                                    onTap: () => _openDatePicker(context),
                                  ),

                                  // DateTime
                                  ListTile(
                                    contentPadding: .symmetric(horizontal: 2),
                                    leading: Icon(Icons.schedule),
                                    title: Row(
                                      children: [
                                        state.dateTime == null
                                            ? Text(
                                                AppStrings.addDateTime,
                                                style: const TextStyle(
                                                  fontSize: 15,
                                                ),
                                              )
                                            : DismissibleChip(
                                                label: state.dateTime!
                                                    .formattedString(),
                                                onDismiss: () => cubit
                                                    .onDateTimeChanged(null),
                                              ),

                                        Spacer(),
                                      ],
                                    ),
                                    onTap: () => _openDateTimePicker(context),
                                  ),

                                  // Subtask
                                  if (!state.isSubtask)
                                    SubtaskView(
                                      subtasks: state.subtasks,
                                      onAddSubtask: cubit.onAddSubtask,
                                      onTitleChanged: (subtask, title) => cubit
                                          .onSubtaskTitleChange(subtask, title),
                                      onCheckChanged: (subtask) =>
                                          cubit.onCompleteSubtask(subtask),
                                      onDismiss: (subtask) =>
                                          cubit.onDismissSubtask(subtask),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Padding(
                    padding: .all(14),
                    child: FilledButton(
                      onPressed: () {
                        if (state.isCompleted) {
                          cubit.onToggleCompleted();
                        } else {
                          cubit.onToggleCompleted();
                          router.pop();
                        }
                      },
                      style: FilledButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                      child: Text(
                        state.isCompleted
                            ? AppStrings.markUncompleted
                            : AppStrings.markCompleted,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
