import 'package:get/get.dart';
import 'package:task_manager/ui/controller/sign_in_controller.dart';

import 'ui/controller/auth_controller.dart';
import 'ui/controller/sign_up_controller.dart';

class ControllBinder extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignInController());
    Get.lazyPut(() => SignUpController());
    Get.put(AuthController());
  }
}
