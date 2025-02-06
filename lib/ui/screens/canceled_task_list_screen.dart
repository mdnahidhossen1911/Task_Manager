import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/ui/controller/cancel_task_list_controller.dart';

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
  final CancelTaskListController _cancelTaskListController =
      Get.find<CancelTaskListController>();

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
    return GetBuilder<CancelTaskListController>(builder: (controller) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Visibility(
            visible: controller.inProgress == false,
            replacement: const CenteredCircularProgressIndicator(),
            child: _buildTaskListView()),
      );
    });
  }

  Widget _buildTaskListView() {
    return GetBuilder<CancelTaskListController>(builder: (controller) {
      return ListView.builder(
        itemCount: controller.taskListModel?.length ?? 0,
        padding: EdgeInsets.symmetric(vertical: 10),
        itemBuilder: (context, index) {
          return TaskItemWidget(
            ontabChangeStatus: (status) {
              _upgradeStatus(index, status);
            },
            ontabDetele: () {
              _deleteTaskItem(index);
            },
            taskModel: controller.taskListModel![index],
          );
        },
      );
    });
  }

  Future<void> _getCanceledTaskList() async {
    bool isSuccess = await _cancelTaskListController.getList();
    if (isSuccess == false) {
      showSnackBarMessage(
          context, _cancelTaskListController.errormassege, false);
    }
  }

  Future<void> _deleteTaskItem(int index) async {
    final String? _taskId = _cancelTaskListController.taskListModel![index].sId;
    showSnackBarMessage(context, "Deleting....", true);

    NetworkResponse response =
        await NetworkCaller.getRequest(url: Urls.deleteTask(_taskId!));
    if (response.isSuccess) {
      showSnackBarMessage(context, "Task Deleted", true);
      _cancelTaskListController.taskListModel!.removeAt(index);
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
      final String? _taskId =
          _cancelTaskListController.taskListModel![index].sId;

      NetworkResponse response = await NetworkCaller.getRequest(
          url: Urls.UpgradeTask(_taskId!, status));
      if (response.isSuccess) {
        showSnackBarMessage(context, "Task Update", true);
        _cancelTaskListController.taskListModel!.removeAt(index);
        setState(() {});
      } else {
        showSnackBarMessage(context, response.errorMessage, false);
      }
    }
  }
}
