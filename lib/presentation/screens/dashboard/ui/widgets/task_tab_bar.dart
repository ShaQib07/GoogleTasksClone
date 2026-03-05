import 'package:flutter/material.dart';
import 'package:google_tasks_clone/domain/entities/task_tab_entity.dart';

import '../../../../../resources/app_strings.dart';

class TaskTabBar extends StatelessWidget {
  const TaskTabBar({
    super.key,
    required this.tabs,
    required this.onCreateNewList,
  });

  final List<TaskTabEntity> tabs;
  final VoidCallback onCreateNewList;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: kTextTabBarHeight,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TabBar(
                  isScrollable: true,
                  tabAlignment: TabAlignment.start,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  dividerColor: Colors.transparent,
                  tabs: [
                    const Tab(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [Icon(Icons.star)],
                      ),
                    ),

                    for (var tab in tabs) Tab(child: Text(tab.tabName)),
                  ],
                ),

                // Create new list
                InkWell(
                  onTap: onCreateNewList,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(width: 8),

                      Icon(Icons.add),

                      const SizedBox(width: 4),

                      Text(AppStrings.newList),

                      const SizedBox(width: 16),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        Divider(height: 1),
      ],
    );
  }
}
