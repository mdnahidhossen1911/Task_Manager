import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:task_manager/ui/controller/new_task_list_controller.dart';
import 'package:task_manager/ui/controller/task_delete_controller.dart';
import 'package:task_manager/ui/controller/task_udate_controller.dart';
import 'package:task_manager/ui/utils/status.dart';

import '../../data/models/task_count_model.dart';
import '../controller/summary_task_list_controller.dart';
import '../utils/app_colors.dart';
import '../widgets/background_screen.dart';
import '../widgets/centered_circular_progress_indicator.dart';
import '../widgets/snack_bar_massage.dart';
import '../widgets/task_item_widget.dart';
import '../widgets/task_status_summary_count.dart';
import '../widgets/tm_appBar.dart';
import 'add_new_task_screen.dart';

class NewTaskListScreen extends StatefulWidget {
  const NewTaskListScreen({super.key});

  @override
  State<NewTaskListScreen> createState() => _NewTaskListScreenState();
}

class _NewTaskListScreenState extends State<NewTaskListScreen> {
  final NewTaskListController _newTaskListController =
      Get.find<NewTaskListController>();

  final SummaryTaskListController _summaryTaskListController =
      Get.find<SummaryTaskListController>();

  @override
  void initState() {
    super.initState();
    _newTaskListController.listClear();
    _getTaskCountByStatus();
  }

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
        onPressed: () {
          Get.toNamed(AddNewTaskScreen.name)?.then(
            (value) {
              if (value == true) {
                _getTaskCountByStatus();
              }
            },
          );
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildNewTaskListview() {
    return GetBuilder<NewTaskListController>(builder: (controller) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: Visibility(
            visible: controller.inProgress == false,
            replacement: const CenteredCircularProgressIndicator(),
            child: _buildTaskListView()),
      );
    });
  }

  Widget _buildTaskListView() {
    return GetBuilder<NewTaskListController>(builder: (controller) {
      return ListView.builder(
        shrinkWrap: true,
        primary: false,
        padding: EdgeInsets.only(bottom: 80),
        itemCount: controller.taskListModel?.length ?? 0,
        itemBuilder: (context, index) {
          return TaskItemWidget(
            ontabDetele: () {
              _deleteTaskItem(index);
            },
            ontabChangeStatus: (status) {
              _upgradeStatus(index, status);
            },
            taskModel: controller.taskListModel![index],
          );
        },
      );
    });
  }

  Widget _buildTaskSummaryByStatus() {
    return GetBuilder<SummaryTaskListController>(builder: (controller) {
      return Visibility(
        visible: controller.inProgress == false,
        replacement: const CenteredCircularProgressIndicator(),
        child: Padding(
          padding: const EdgeInsets.only(top: 8, left: 8, right: 8, bottom: 2),
          child: SizedBox(
            height: 90,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: controller.StatusModel?.length ?? 0,
              itemBuilder: (context, index) {
                final TaskCountModel model = controller.StatusModel![index];
                return TaskStatusSummaryCount(
                  title: model.sId ?? '',
                  count: model.sum.toString(),
                );
              },
            ),
          ),
        ),
      );
    });
  }

  Future<void> _getTaskCountByStatus() async {
    bool isSuccess = await _summaryTaskListController.summaryApiCall();
    if (isSuccess) {
      if (_summaryTaskListController.StatusModel!.isNotEmpty) {
        _getNewTaskList();
      }
    } else {
      showSnackBarMessage(
          context, _summaryTaskListController.errorMessage, false);
    }
  }

  Future<void> _getNewTaskList() async {
    bool isSuccess = await _newTaskListController.getList();
    if (isSuccess == false) {
      showSnackBarMessage(context, _newTaskListController.errormassege, false);
    }
  }

  Future<void> _deleteTaskItem(int index) async {
    final String? taskId = _newTaskListController.taskListModel![index].sId;
    showSnackBarMessage(context, "Deleting....", true);

    TaskDeleteController deleteController = Get.find<TaskDeleteController>();
    bool isSuccess = await deleteController.deleted(taskId!);

    if (isSuccess) {
      showSnackBarMessage(context, "Task Deleted", true);
      _newTaskListController.deleteItem(index);
      // again reload summary list
      bool isSuccsee =
          await _summaryTaskListController.summaryApiCallWithOutProgress();
      if (isSuccsee == false) {
        showSnackBarMessage(
            context, _summaryTaskListController.errorMessage, false);
      }
    } else {
      showSnackBarMessage(context, deleteController.errorMassege, false);
    }
  }

  Future<void> _upgradeStatus(int index, String status) async {
    final String? taskId = _newTaskListController.taskListModel![index].sId;

    if (status == Status.New) {
      showSnackBarMessage(context, "You are in 'New status'.", false);
    } else {
      showSnackBarMessage(context, "status updating.....", true);

      TaskUdateController taskUdateController = Get.find<TaskUdateController>();
      bool isSuccess = await taskUdateController.uppdate(taskId!, status);

      if (isSuccess) {
        showSnackBarMessage(context, "Task Update", true);
        _newTaskListController.deleteItem(index);
        // again reload summary list
        await _summaryTaskListController.summaryApiCallWithOutProgress();
      } else {
        showSnackBarMessage(context, taskUdateController.errorMassege, false);
      }
    }
  }
}
