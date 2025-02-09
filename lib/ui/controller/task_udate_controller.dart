import 'package:get/get.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/data/utils/urls.dart';

class TaskUdateController extends GetxController {
  String _errorMassage = '';
  String get errorMassege => _errorMassage;

  Future<bool> uppdate(String taskId, String status) async {
    bool isSuccess = false;
    NetworkResponse response =
        await NetworkCaller.getRequest(url: Urls.UpgradeTask(taskId, status));

    if (response.isSuccess) {
      _errorMassage = '';
      isSuccess = true;
    } else {
      _errorMassage = response.errorMessage;
      isSuccess = false;
    }
    return isSuccess;
  }
}
