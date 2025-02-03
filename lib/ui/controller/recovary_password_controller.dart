import 'package:get/get.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/data/utils/urls.dart';

class RecovaryPasswordController extends GetxController {
  bool _inProgress = true;
  String _errorMessage = '';

  bool get inProgress => _inProgress;
  String get errorMessage => _errorMessage;

  Future<bool> recovaryPass(String gmail, String otp, String pass) async {
    bool isSuccess = false;
    _inProgress = false;
    update();

    Map<String, dynamic> recponseBody = {
      "email": gmail,
      "OTP": otp,
      "password": pass
    };

    NetworkResponse response = await NetworkCaller.postRequest(
        url: Urls.recoverResetPass, body: recponseBody);

    if (response.isSuccess) {
      isSuccess = true;
      _errorMessage = '';
    } else {
      isSuccess = false;
      _errorMessage = response.errorMessage;
    }

    _inProgress = true;
    update();

    return isSuccess;
  }
}
