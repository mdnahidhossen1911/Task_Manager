import 'package:get/get.dart';
import 'package:task_manager/data/models/task_count_by_status_model.dart';
import 'package:task_manager/data/models/task_count_model.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/data/utils/urls.dart';

class SummaryTaskListController extends GetxController {
  bool _inProgress = false;
  String _errorMessage = '';
  TaskCountByStatusModel? taskCountByStatusModel;

  bool get inProgress => _inProgress;
  String get errorMessage => _errorMessage;
  List<TaskCountModel>? get StatusModel =>
      taskCountByStatusModel?.taskByStatusList;

  Future<bool> summaryApiCall() async {
    bool isSuccess = true;

    _inProgress = true;
    update();

    final NetworkResponse response =
        await NetworkCaller.getRequest(url: Urls.taskCountByStatusUrl);

    if (response.isSuccess) {
      isSuccess = true;
      _errorMessage = '';
      taskCountByStatusModel =
          TaskCountByStatusModel.fromJson(response.responseData!);
    } else {
      isSuccess = false;
      _errorMessage = response.errorMessage;
    }

    _inProgress = false;
    update();
    return isSuccess;
  }

  Future<bool> summaryApiCallWithOutProgress() async {
    bool isSuccess = true;
    final NetworkResponse response =
        await NetworkCaller.getRequest(url: Urls.taskCountByStatusUrl);

    if (response.isSuccess) {
      isSuccess = true;
      _errorMessage = '';
      taskCountByStatusModel =
          TaskCountByStatusModel.fromJson(response.responseData!);
    } else {
      isSuccess = false;
      _errorMessage = response.errorMessage;
    }
    update();
    return isSuccess;
  }
}
