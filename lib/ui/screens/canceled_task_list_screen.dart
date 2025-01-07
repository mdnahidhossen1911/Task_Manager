import 'package:flutter/material.dart';

import '../widgets/background_screen.dart';
import '../widgets/task_item_widget.dart';
import '../widgets/tm_appBar.dart';

class CanceledTaskListScreen extends StatefulWidget {
  const CanceledTaskListScreen({super.key});

  @override
  State<CanceledTaskListScreen> createState() => _CanceledTaskListScreenState();
}

class _CanceledTaskListScreenState extends State<CanceledTaskListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMAppBar(),
      body: BackgroundScreen(
        child: _buildCanceledTaskListview(),
      ),
    );
  }

  Widget _buildCanceledTaskListview() {
    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      shrinkWrap: true,
      primary: false,
      itemCount: 10,
      itemBuilder: (context, index) {
        return TaskItemWidget(
          statusColor: Colors.redAccent,
        );
      },
    );
  }
}
