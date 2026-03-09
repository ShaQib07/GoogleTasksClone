import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../resources/app_strings.dart';
import '../cubit/task_cubit.dart';
import '../cubit/task_state.dart';

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

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskCubit, TaskState>(
      builder: (context, state) {
        final cubit = context.read<TaskCubit>();

        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            top: 8,
          ),
          child: Column(
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

              Row(
                children: [
                  const SizedBox(width: 8),

                  IconButton(
                    onPressed: cubit.enableDescription,
                    icon: const Icon(Icons.notes),
                  ),

                  IconButton(
                    onPressed: cubit.enableDescription,
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

                  const SizedBox(width: 24),
                ],
              ),

              const SizedBox(height: 12),
            ],
          ),
        );
      },
    );
  }
}
