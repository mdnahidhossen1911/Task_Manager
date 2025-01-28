import 'package:flutter/material.dart';

import '../../data/models/task_list_by_status_model.dart';
import '../../data/services/network_caller.dart';
import '../../data/utils/urls.dart';
import '../widgets/background_screen.dart';
import '../widgets/centered_circular_progress_indicator.dart';
import '../widgets/snack_bar_massage.dart';
import '../widgets/task_item_widget.dart';
import '../widgets/tm_appBar.dart';

class CanceledTaskListScreen extends StatefulWidget {
  const CanceledTaskListScreen({super.key});

  @override
  State<CanceledTaskListScreen> createState() => _CanceledTaskListScreenState();
}

class _CanceledTaskListScreenState extends State<CanceledTaskListScreen> {
  bool _getCanceledTaskListInProgress = false;
  TaskListByStatusModel? canceledTaskListModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCanceledTaskList();
  }

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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Visibility(
          visible: _getCanceledTaskListInProgress == false,
          replacement: const CenteredCircularProgressIndicator(),
          child: _buildTaskListView()),
    );
  }

  Widget _buildTaskListView() {
    return ListView.builder(
      itemCount: canceledTaskListModel?.taskList?.length ?? 0,
      padding: EdgeInsets.symmetric(vertical: 10),
      itemBuilder: (context, index) {
        return TaskItemWidget(
          ontabChangeStatus: (status) {
            _upgradeStatus(index, status);
          },
          ontabDetele: () {
            _deleteTaskItem(index);
          },
          taskModel: canceledTaskListModel!.taskList![index],
        );
      },
    );
  }

  Future<void> _getCanceledTaskList() async {
    _getCanceledTaskListInProgress = true;
    setState(() {});
    final NetworkResponse response =
        await NetworkCaller.getRequest(url: Urls.taskListByStatusUrl('Cancel'));
    if (response.isSuccess) {
      canceledTaskListModel =
          TaskListByStatusModel.fromJson(response.responseData!);
    } else {
      showSnackBarMessage(context, response.errorMessage, false);
    }
    _getCanceledTaskListInProgress = false;
    setState(() {});
  }

  Future<void> _deleteTaskItem(int index) async {
    final String? _taskId = canceledTaskListModel!.taskList![index].sId;
    showSnackBarMessage(context, "Deleting....", true);

    NetworkResponse response =
        await NetworkCaller.getRequest(url: Urls.deleteTask(_taskId!));
    if (response.isSuccess) {
      showSnackBarMessage(context, "Task Deleted", true);
      canceledTaskListModel?.taskList?.removeAt(index);
      setState(() {});
    } else {
      showSnackBarMessage(context, response.errorMessage, false);
    }
  }

  Future<void> _upgradeStatus(int index, String status) async {
    if (status == "Cancel") {
      showSnackBarMessage(context, "You are in 'Cancel status'.", false);
    } else {
      showSnackBarMessage(context, "status updating.....", true);
      final String? _taskId = canceledTaskListModel!.taskList![index].sId;

      NetworkResponse response = await NetworkCaller.getRequest(
          url: Urls.UpgradeTask(_taskId!, status));
      if (response.isSuccess) {
        showSnackBarMessage(context, "Task Update", true);
        canceledTaskListModel?.taskList?.removeAt(index);
        setState(() {});
      } else {
        showSnackBarMessage(context, response.errorMessage, false);
      }
    }
  }
}
