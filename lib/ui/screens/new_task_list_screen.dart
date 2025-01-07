import 'package:flutter/material.dart';
import 'package:task_manager/ui/utils/app_colors.dart';
import 'package:task_manager/ui/widgets/background_screen.dart';
import 'package:task_manager/ui/widgets/task_item_widget.dart';

import '../widgets/task_status_summary_count.dart';
import '../widgets/tm_appBar.dart';

class NewTaskListScreen extends StatefulWidget {
  const NewTaskListScreen({super.key});

  @override
  State<NewTaskListScreen> createState() => _NewTaskListScreenState();
}

class _NewTaskListScreenState extends State<NewTaskListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMAppBar(),
      body: BackgroundScreen(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildTaskSummaryByStatus(),
              _buildNewTaskListview(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.themColor,
        onPressed: () {},
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildNewTaskListview() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ListView.builder(
        shrinkWrap: true,
        primary: false,
        itemCount: 10,
        itemBuilder: (context, index) {
          return TaskItemWidget(
            statusColor: Colors.blue,
          );
        },
      ),
    );
  }

  Widget _buildTaskSummaryByStatus() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0, left: 8, right: 8, bottom: 4),
        child: Row(
          children: [
            TaskStatusSummaryCount(count: 0, title: 'New Task'),
            TaskStatusSummaryCount(count: 0, title: 'Completed'),
            TaskStatusSummaryCount(count: 0, title: 'Canceled'),
            TaskStatusSummaryCount(count: 0, title: 'Progress'),
          ],
        ),
      ),
    );
  }
}
