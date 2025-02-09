import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:task_manager/ui/controller/complete_task_list_controller.dart';
import 'package:task_manager/ui/controller/task_delete_controller.dart';

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
  final CompleteTaskListController _completedTaskListController =
      Get.find<CompleteTaskListController>();

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
    return GetBuilder<CompleteTaskListController>(builder: (controller) {
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
    return GetBuilder<CompleteTaskListController>(builder: (controller) {
      return ListView.builder(
        shrinkWrap: true,
        primary: false,
        itemCount: controller.taskListModel?.length ?? 0,
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
            taskModel: controller.taskListModel![index],
          );
        },
      );
    });
  }

  Future<void> _getCompletedTaskList() async {
    bool isSuccess = await _completedTaskListController.getList();

    if (isSuccess == false) {
      showSnackBarMessage(
          context, _completedTaskListController.errormassege, false);
    }
  }

  Future<void> _deleteTaskItem(int index) async {
    final String? taskId =
        _completedTaskListController.taskListModel![index].sId;
    showSnackBarMessage(context, "Deleting....", true);

    TaskDeleteController deleteController = Get.find<TaskDeleteController>();
    bool isSuccess = await deleteController.deleted(taskId!);

    if (isSuccess) {
      showSnackBarMessage(context, "Task Deleted", true);
      _completedTaskListController.deleteItem(index);
    } else {
      showSnackBarMessage(context, deleteController.errorMassege, false);
    }
  }

  Future<void> _upgradeStatus(int index, String status) async {
    if (status == "Complete") {
      showSnackBarMessage(context, "You are in 'Complete status'.", false);
    } else {
      showSnackBarMessage(context, "status updating.....", true);
      final String? _taskId =
          _completedTaskListController.taskListModel?[index].sId;

      NetworkResponse response = await NetworkCaller.getRequest(
          url: Urls.UpgradeTask(_taskId!, status));
      if (response.isSuccess) {
        showSnackBarMessage(context, "Task Update", true);
        _completedTaskListController.taskListModel?.removeAt(index);
        setState(() {});
      } else {
        showSnackBarMessage(context, response.errorMessage, false);
      }
    }
  }
}
