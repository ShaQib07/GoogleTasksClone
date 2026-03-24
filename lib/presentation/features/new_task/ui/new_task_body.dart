import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_tasks_clone/core/extensions/date_time.dart';
import 'package:google_tasks_clone/presentation/core/widgets/dismissible_chip.dart';

import '../../../core/resources/app_strings.dart';
import '../cubit/new_task_cubit.dart';
import '../cubit/new_task_state.dart';
import '../../../core/widgets/date_time_picker.dart';

class NewTaskBody extends StatefulWidget {
  const NewTaskBody({super.key, this.tabId});

  final int? tabId;

  @override
  State<StatefulWidget> createState() => _NewTaskBodyState();
}

class _NewTaskBodyState extends State<NewTaskBody> {
  late final TextEditingController _titleController;
  late final TextEditingController _descController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _descController = TextEditingController();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  void _openDateTimePicker(BuildContext context) async {
    final cubit = context.read<NewTaskCubit>();
    final dateTime = await showDialog<DateTime>(
      context: context,
      builder: (_) => Dialog(
        insetPadding: const EdgeInsets.all(32),
        child: DateTimePicker(selectedDateTime: cubit.state.dateTime),
      ),
    );

    if (dateTime != null) {
      cubit.onDateTimeChanged(dateTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewTaskCubit, NewTaskState>(
      builder: (context, state) {
        final cubit = context.read<NewTaskCubit>();

        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            top: 8,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Title
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: TextField(
                  style: const TextStyle(fontSize: 16),
                  autofocus: true,
                  controller: _titleController,
                  onChanged: cubit.onTitleChanged,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: AppStrings.newTask,
                  ),
                ),
              ),

              // Description
              if (state.isDescriptionEnabled)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: TextField(
                    style: const TextStyle(fontSize: 14),
                    controller: _descController,
                    onChanged: cubit.onDescChanged,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: AppStrings.addDetails,
                    ),
                  ),
                ),

              // DateTime
              if (state.dateTime != null)
                Padding(
                  padding: const EdgeInsets.only(left: 24, top: 16),
                  child: DismissibleChip(
                    label: state.dateTime!.formattedString(),
                    onDismiss: () => cubit.onDateTimeChanged(null),
                    onPress: () => _openDateTimePicker(context),
                  ),
                ),

              Padding(
                padding: const EdgeInsets.only(left: 8, right: 24),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: cubit.enableDescription,
                      icon: const Icon(Icons.notes),
                    ),

                    IconButton(
                      onPressed: () => _openDateTimePicker(context),
                      icon: const Icon(Icons.schedule),
                    ),

                    IconButton(
                      onPressed: cubit.toggleFavorite,
                      icon: Icon(
                        state.isFavorite
                            ? Icons.star
                            : Icons.star_border_outlined,
                      ),
                    ),

                    const Spacer(),

                    TextButton(
                      onPressed: state.title.isEmpty
                          ? null
                          : () {
                              cubit.createTask(widget.tabId);
                              Navigator.pop(context);
                            },
                      child: const Text(AppStrings.save),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }
}
