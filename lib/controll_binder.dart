import 'package:get/get.dart';
import 'package:task_manager/ui/controller/sign_in_controller.dart';

class ControllBinder extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignInController());
  }
}
