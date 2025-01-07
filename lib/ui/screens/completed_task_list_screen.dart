import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../widgets/background_screen.dart';
import '../widgets/task_item_widget.dart';
import '../widgets/tm_appBar.dart';

class CompletedTaskListScreen extends StatefulWidget {
  const CompletedTaskListScreen({super.key});

  @override
  State<CompletedTaskListScreen> createState() =>
      _CompletedTaskListScreenState();
}

class _CompletedTaskListScreenState extends State<CompletedTaskListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMAppBar(),
      body: BackgroundScreen(
        child: _buildCompletedTaskListview(),
      ),
    );
  }

  Widget _buildCompletedTaskListview() {
    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      shrinkWrap: true,
      primary: false,
      itemCount: 10,
      itemBuilder: (context, index) {
        return TaskItemWidget(
          statusColor: AppColors.themColor,
        );
      },
    );
  }
}
