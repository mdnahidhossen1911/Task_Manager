import 'package:get/get.dart';
import 'package:task_manager/data/utils/urls.dart';

import '../../data/services/network_caller.dart';

class ForgotPasswordOtpController extends GetxController {
  bool _inProgress = true;
  String _errorMessage = '';

  bool get inProgress => _inProgress;
  String get errorMessage => _errorMessage;

  Future<bool> verifyOtp(String gmail, String otp) async {
    bool isSuccess = false;
    _inProgress = false;
    update();

    NetworkResponse response =
        await NetworkCaller.getRequest(url: Urls.otpVerify(gmail, otp));

    if (response.isSuccess) {
      if (response.responseData!['status'] == "fail") {
        _errorMessage = 'Invalid OTP Code';
        isSuccess = false;
      } else {
        isSuccess = true;
        _errorMessage = '';
      }
    } else {
      _errorMessage = response.errorMessage;
      isSuccess = false;
    }

    _inProgress = true;
    update();

    return isSuccess;
  }
}
