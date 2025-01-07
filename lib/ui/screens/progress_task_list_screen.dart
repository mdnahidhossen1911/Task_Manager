import 'package:flutter/material.dart';

import '../widgets/background_screen.dart';
import '../widgets/task_item_widget.dart';
import '../widgets/tm_appBar.dart';

class ProgressTaskListScreen extends StatefulWidget {
  const ProgressTaskListScreen({super.key});

  @override
  State<ProgressTaskListScreen> createState() => _ProgressTaskListScreenState();
}

class _ProgressTaskListScreenState extends State<ProgressTaskListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMAppBar(),
      body: BackgroundScreen(
        child: _buildCompletedTaskListview(),
      ),
    );
  }

  _buildCompletedTaskListview() {
    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      shrinkWrap: true,
      primary: false,
      itemCount: 10,
      itemBuilder: (context, index) {
        return TaskItemWidget(
          statusColor: Colors.pinkAccent,
        );
      },
    );
  }
}
