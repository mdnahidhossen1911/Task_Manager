import 'package:get/get.dart';

import '../../data/models/user_model.dart';
import '../../data/services/network_caller.dart';
import '../../data/utils/urls.dart';
import 'auth_controller.dart';

class SignInController extends GetxController {
  bool _inProgress = true;
  String? _errorMessage;

  bool get inProgress => _inProgress;
  String? get errorMessage => _errorMessage;

  Future<bool> signIn(String email, String pass) async {
    bool isSucess = false;
    _inProgress = false;
    update();

    Map<String, dynamic> requestBody = {
      "email": email,
      "password": pass,
    };

    NetworkCaller.isSignInScreen = true;

    NetworkResponse response = await NetworkCaller.postRequest(
      url: Urls.loginUrl,
      body: requestBody,
    );

    if (response.isSuccess) {
      String token = response.responseData!['token'];
      UserModel userModel = UserModel.fromJson(response.responseData!['data']);
      await AuthController.saveUserData(token, userModel);
      isSucess = true;
      _errorMessage = null;
    } else {
      if (response.statusCode == 401) {
        _errorMessage = 'Email/Password is invalid! Try again.';
      } else {
        _errorMessage = response.errorMessage;
        print(response.errorMessage);
      }
    }

    _inProgress = true;
    update();
    return isSucess;
  }
}
