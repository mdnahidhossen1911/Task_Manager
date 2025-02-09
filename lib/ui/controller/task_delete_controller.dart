import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:task_manager/data/utils/urls.dart';

import '../../data/services/network_caller.dart';

class TaskDeleteController extends GetxController {
  String _errorMassage = '';
  String get errorMassege => _errorMassage;

  Future<bool> deleted(String taskId) async {
    bool isSuccess = false;
    final NetworkResponse response =
        await NetworkCaller.getRequest(url: Urls.deleteTask(taskId));

    if (response.isSuccess) {
      isSuccess = true;
      _errorMassage = '';
    } else {
      _errorMassage = response.errorMessage;
      isSuccess = false;
    }
    return isSuccess;
  }
}
