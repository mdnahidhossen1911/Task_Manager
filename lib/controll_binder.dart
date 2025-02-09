import 'package:get/get.dart';
import 'package:task_manager/ui/controller/create_new_task_controller.dart';
import 'package:task_manager/ui/controller/forgot_password_otp_Controller.dart';
import 'package:task_manager/ui/controller/image_picker_controller.dart';
import 'package:task_manager/ui/controller/new_task_list_controller.dart';
import 'package:task_manager/ui/controller/profile_udate_controller.dart';
import 'package:task_manager/ui/controller/progress_task_list_controller.dart';
import 'package:task_manager/ui/controller/recovary_password_controller.dart';
import 'package:task_manager/ui/controller/sign_in_controller.dart';
import 'package:task_manager/ui/controller/summary_task_list_controller.dart';
import 'package:task_manager/ui/controller/task_delete_controller.dart';
import 'package:task_manager/ui/controller/task_udate_controller.dart';

import 'ui/controller/auth_controller.dart';
import 'ui/controller/cancel_task_list_controller.dart';
import 'ui/controller/complete_task_list_controller.dart';
import 'ui/controller/forgot_password_gmail_Controller.dart';
import 'ui/controller/sign_up_controller.dart';

class ControllBinder extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignInController());
    Get.lazyPut(() => SignUpController());
    Get.lazyPut(() => ForgotPasswordGmailController());
    Get.lazyPut(() => ForgotPasswordOtpController());
    Get.lazyPut(() => RecovaryPasswordController());
    Get.lazyPut(() => TaskDeleteController());
    Get.lazyPut(() => TaskUdateController());

    Get.lazyPut(() => CreateNewTaskController());
    Get.lazyPut(() => ProfileUdateController());

    Get.lazyPut(() => ImagePickerController());

    Get.put(NewTaskListController());
    Get.put(CompleteTaskListController());
    Get.put(ProgressTaskListController());
    Get.put(CancelTaskListController());

    Get.put(SummaryTaskListController());
    Get.put(AuthController());
  }
}
