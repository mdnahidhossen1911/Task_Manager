import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:task_manager/ui/controller/summary_task_list_controller.dart';

import '../../data/models/task_count_model.dart';
import '../../data/models/task_list_by_status_model.dart';
import '../../data/services/network_caller.dart';
import '../../data/utils/urls.dart';
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
  bool _getNewTaskListInProgress = false;
  TaskListByStatusModel? newTaskListModel;

  final SummaryTaskListController _summaryTaskListController =
      Get.find<SummaryTaskListController>();

  @override
  void initState() {
    super.initState();
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
                print(value);
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
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Visibility(
          visible: _getNewTaskListInProgress == false,
          replacement: const CenteredCircularProgressIndicator(),
          child: _buildTaskListView()),
    );
  }

  Widget _buildTaskListView() {
    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      padding: EdgeInsets.only(bottom: 80),
      itemCount: newTaskListModel?.taskList?.length ?? 0,
      itemBuilder: (context, index) {
        return TaskItemWidget(
          ontabDetele: () {
            _deleteTaskItem(index);
          },
          ontabChangeStatus: (status) {
            _upgradeStatus(index, status);
          },
          taskModel: newTaskListModel!.taskList![index],
        );
      },
    );
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
      if (_summaryTaskListController.StatusModel!.length != 0) {
        _getNewTaskList();
      }
    } else {
      showSnackBarMessage(
          context, _summaryTaskListController.errorMessage, false);
    }
  }

  Future<void> _getNewTaskList() async {
    _getNewTaskListInProgress = true;
    setState(() {});
    final NetworkResponse response =
        await NetworkCaller.getRequest(url: Urls.taskListByStatusUrl('New'));
    if (response.isSuccess) {
      newTaskListModel = TaskListByStatusModel.fromJson(response.responseData!);
    } else {
      showSnackBarMessage(context, response.errorMessage, false);
    }
    _getNewTaskListInProgress = false;
    setState(() {});
  }

  Future<void> _deleteTaskItem(int index) async {
    final String? _taskId = newTaskListModel!.taskList![index].sId;
    showSnackBarMessage(context, "Deleting....", true);

    NetworkResponse response =
        await NetworkCaller.getRequest(url: Urls.deleteTask(_taskId!));
    if (response.isSuccess) {
      showSnackBarMessage(context, "Task Deleted", true);
      newTaskListModel?.taskList?.removeAt(index);

      // again reload summary list
      bool isSuccsee =
          await _summaryTaskListController.summaryApiCallWithOutProgress();
      if (isSuccsee = false) {
        showSnackBarMessage(
            context, _summaryTaskListController.errorMessage, false);
      }

      setState(() {});
    } else {
      showSnackBarMessage(context, response.errorMessage, false);
    }
  }

  Future<void> _upgradeStatus(int index, String status) async {
    final String? _taskId = newTaskListModel!.taskList![index].sId;

    if (status == "New") {
      showSnackBarMessage(context, "You are in 'New status'.", false);
    } else {
      showSnackBarMessage(context, "status updating.....", true);
      NetworkResponse response = await NetworkCaller.getRequest(
          url: Urls.UpgradeTask(_taskId!, status));
      if (response.isSuccess) {
        showSnackBarMessage(context, "Task Update", true);
        newTaskListModel?.taskList?.removeAt(index);
        _getTaskCountByStatus();
        setState(() {});
      } else {
        showSnackBarMessage(context, response.errorMessage, false);
      }
    }
  }
}
