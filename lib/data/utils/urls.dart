class Urls {
  static const String _baseUrl = 'https://task.teamrabbil.com/api/v1';

  static const String registrationUrl = '$_baseUrl/registration';
  static const String loginUrl = '$_baseUrl/login';
  static const String createTaskUrl = '$_baseUrl/createTask';
  static const String taskCountByStatusUrl = '$_baseUrl/taskStatusCount';
  static const String recoverResetPass = '$_baseUrl/RecoverResetPass';

  static String gmailVerify(String gmail) =>
      '$_baseUrl/RecoverVerifyEmail/$gmail';

  static String otpVerify(String gmail, String otp) =>
      '$_baseUrl/RecoverVerifyOTP/$gmail/$otp';

  static String taskListByStatusUrl(String status) =>
      '$_baseUrl/listTaskByStatus/$status';

  static String deleteTask(String id) => '$_baseUrl/deleteTask/$id';
  static String UpgradeTask(String sid, String status) =>
      '$_baseUrl/updateTaskStatus/$sid/$status';

  static const String updateProfile = '$_baseUrl/profileUpdate';
}
