import 'package:get/get.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/data/utils/urls.dart';

class CreateNewTaskController extends GetxController {
  bool _inprogress = false;
  bool get inProgress => _inprogress;

  String _errorMessege = '';
  String get errorMessege => _errorMessege;

  Future<bool> upload(Map<String, dynamic> uploadMap) async {
    bool isSuccess = false;
    _inprogress = true;
    update();

    final NetworkResponse response = await NetworkCaller.postRequest(
        url: Urls.createTaskUrl, body: uploadMap);

    if (response.isSuccess) {
      isSuccess = true;
      _errorMessege = '';
    } else {
      _errorMessege = response.errorMessage;
    }

    _inprogress = false;
    update();
    return isSuccess;
  }
}
