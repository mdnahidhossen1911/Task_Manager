import 'package:get/get.dart';
import 'package:task_manager/data/models/task_list_by_status_model.dart';
import 'package:task_manager/data/models/task_model.dart';
import 'package:task_manager/data/services/network_caller.dart';

import '../../data/utils/urls.dart';
import '../utils/status.dart';

class NewTaskListController extends GetxController {
  bool _inprogress = false;
  String _errorMassege = '';
  TaskListByStatusModel? _taskListByStatusModel;
  bool get inProgress => _inprogress;
  String get errormassege => _errorMassege;

  List<TaskModel>? get taskListModel => _taskListByStatusModel?.taskList;

  Future<bool> getList() async {
    bool isSuccess = false;
    _inprogress = true;
    update();

    final NetworkResponse response = await NetworkCaller.getRequest(
        url: Urls.taskListByStatusUrl(Status.New));
    if (response.isSuccess) {
      isSuccess = true;
      _errorMassege = '';
      _taskListByStatusModel =
          TaskListByStatusModel.fromJson(response.responseData!);
    } else {
      isSuccess = false;
      _errorMassege = response.errorMessage;
    }

    _inprogress = false;
    update();
    return isSuccess;
  }

  void deleteItem(int index) {
    taskListModel?.removeAt(index);
    update();
  }

  void listClear() {
    _taskListByStatusModel?.taskList!.clear();
    update();
  }
}
