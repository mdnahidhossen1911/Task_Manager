import 'package:get/get.dart';

import '../../data/services/network_caller.dart';
import '../../data/utils/urls.dart';

class SignUpController extends GetxController {
  bool _inProgress = true;
  String? _errorMessage;

  bool get inProgress => _inProgress;
  String? get errorMessage => _errorMessage;

  Future<bool> registation(Map<String, dynamic> _requestBody) async {
    bool isSucess = false;
    _inProgress = false;
    update();

    NetworkCaller.isSignInScreen = true;

    final NetworkResponse response = await NetworkCaller.postRequest(
        url: Urls.registrationUrl, body: _requestBody);

    if (response.isSuccess) {
      String status = response.responseData!['status'];
      if (status == 'fail') {
        _errorMessage = 'Already created an account using this email.';
        isSucess = false;
      } else {
        isSucess = true;
      }
    } else {
      _errorMessage = response.errorMessage;
      isSucess = false;
    }

    _inProgress = true;
    update();
    return isSucess;
  }
}
