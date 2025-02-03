import 'package:get/get.dart';
import 'package:task_manager/data/utils/urls.dart';

import '../../data/services/network_caller.dart';

class ForgotPasswordGmailController extends GetxController {
  bool _inProgress = true;
  String _errorMessage = '';

  bool get inProgress => _inProgress;
  String get errorMessage => _errorMessage;

  Future<bool> verifyGmail(String gmail) async {
    bool isSuccess = false;
    _inProgress = false;
    update();

    NetworkResponse response =
        await NetworkCaller.getRequest(url: Urls.gmailVerify(gmail));

    if (response.isSuccess) {
      if (response.responseData!['status'] == 'fail') {
        isSuccess = false;
        _errorMessage = "User Not Found";
      } else {
        isSuccess = true;
        _errorMessage = '';
      }
    } else {
      isSuccess = false;
      _errorMessage = response.errorMessage;
    }

    _inProgress = true;
    update();

    return isSuccess;
  }
}
