import 'package:flutter/material.dart';

import '../../data/models/task_list_by_status_model.dart';
import '../../data/services/network_caller.dart';
import '../../data/utils/urls.dart';
import '../widgets/background_screen.dart';
import '../widgets/centered_circular_progress_indicator.dart';
import '../widgets/snack_bar_massage.dart';
import '../widgets/task_item_widget.dart';
import '../widgets/tm_appBar.dart';

class CompletedTaskListScreen extends StatefulWidget {
  const CompletedTaskListScreen({super.key});

  @override
  State<CompletedTaskListScreen> createState() =>
      _CompletedTaskListScreenState();
}

class _CompletedTaskListScreenState extends State<CompletedTaskListScreen> {
  bool _getCompletedTaskListInProgress = false;
  TaskListByStatusModel? completedTaskListModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCompletedTaskList();
  }

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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Visibility(
          visible: _getCompletedTaskListInProgress == false,
          replacement: const CenteredCircularProgressIndicator(),
          child: _buildTaskListView()),
    );
  }

  Widget _buildTaskListView() {
    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      itemCount: completedTaskListModel?.taskList?.length ?? 0,
      padding: EdgeInsets.symmetric(vertical: 10),
      itemBuilder: (context, index) {
        return TaskItemWidget(
          ontabDetele: () {
            _deleteTaskItem(index);
          },
          ontabChangeStatus: (status) {
            print(status);
            _upgradeStatus(index, status);
          },
          taskModel: completedTaskListModel!.taskList![index],
        );
      },
    );
  }

  Future<void> _getCompletedTaskList() async {
    _getCompletedTaskListInProgress = true;
    setState(() {});
    final NetworkResponse response = await NetworkCaller.getRequest(
        url: Urls.taskListByStatusUrl('Complete'));
    if (response.isSuccess) {
      completedTaskListModel =
          TaskListByStatusModel.fromJson(response.responseData!);
    } else {
      showSnackBarMessage(context, response.errorMessage, false);
    }
    _getCompletedTaskListInProgress = false;
    setState(() {});
  }

  Future<void> _deleteTaskItem(int index) async {
    final String? _taskId = completedTaskListModel!.taskList![index].sId;
    showSnackBarMessage(context, "Deleting....", true);

    NetworkResponse response =
        await NetworkCaller.getRequest(url: Urls.deleteTask(_taskId!));
    if (response.isSuccess) {
      showSnackBarMessage(context, "Task Deleted", true);
      completedTaskListModel?.taskList?.removeAt(index);
      setState(() {});
    } else {
      showSnackBarMessage(context, response.errorMessage, false);
    }
  }

  Future<void> _upgradeStatus(int index, String status) async {
    if (status == "Complete") {
      showSnackBarMessage(context, "You are in 'Complete status'.", false);
    } else {
      showSnackBarMessage(context, "status updating.....", true);
      final String? _taskId = completedTaskListModel!.taskList![index].sId;

      NetworkResponse response = await NetworkCaller.getRequest(
          url: Urls.UpgradeTask(_taskId!, status));
      if (response.isSuccess) {
        showSnackBarMessage(context, "Task Update", true);
        completedTaskListModel?.taskList?.removeAt(index);
        setState(() {});
      } else {
        showSnackBarMessage(context, response.errorMessage, false);
      }
    }
  }
}
