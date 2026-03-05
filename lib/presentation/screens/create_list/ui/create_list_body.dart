import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_tasks_clone/presentation/screens/create_list/cubit/create_list_cubit.dart';
import 'package:google_tasks_clone/resources/app_strings.dart';

import '../../../../domain/entities/task_tab_entity.dart';

class CreateListBody extends StatefulWidget {
  const CreateListBody({super.key, required this.tab});

  final TaskTabEntity? tab;

  @override
  State<CreateListBody> createState() => _CreateListBodyState();
}

class _CreateListBodyState extends State<CreateListBody> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.tab?.tabName ?? '');

    _controller.addListener(
      () => context.read<CreateListCubit>().onTitleChanged(_controller.text),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CreateListCubit>();

    return BlocBuilder<CreateListCubit, String>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: context.router.pop,
              icon: Icon(Icons.close),
            ),
            title: Text(AppStrings.createNewList),
            actions: [
              TextButton(
                onPressed: state.isNotEmpty
                    ? () {
                        cubit.createOrUpdateTab(widget.tab);
                        context.router.pop();
                      }
                    : null,
                child: const Text(AppStrings.done),
              ),
            ],
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              style: const TextStyle(fontSize: 16),
              autofocus: true,
              controller: _controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: AppStrings.enterListTitle,
              ),
            ),
          ),
        );
      },
    );
  }
}
