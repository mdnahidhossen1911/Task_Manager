import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/ui/controller/forgot_password_gmail_Controller.dart';
import 'package:task_manager/ui/utils/app_colors.dart';
import 'package:task_manager/ui/widgets/snack_bar_massage.dart';

import '../widgets/task_widgets.dart';
import 'forgot_password_otp_verification.dart';

class ForgorPasswordEmailVerification extends StatefulWidget {
  const ForgorPasswordEmailVerification({super.key});

  static const String name = '/Forgor-Password/EmailVerification';

  @override
  State<ForgorPasswordEmailVerification> createState() =>
      _ForgorPasswordEmailVerificationState();
}

class _ForgorPasswordEmailVerificationState
    extends State<ForgorPasswordEmailVerification> {
  final TextEditingController _gmailTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final ForgotPasswordGmailController _forgotPasswordGmailController =
      Get.find<ForgotPasswordGmailController>();

  @override
  Widget build(BuildContext context) {
    final textThem = Theme.of(context).textTheme;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BackgroundScreen(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(48),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 96),
                  Text(
                    'Your Email Address',
                    style: textThem.headlineMedium,
                  ),
                  Text(
                    'A 6 digit verification pin will send to your email address',
                    style: textThem.bodyMedium,
                  ),
                  SizedBox(height: 24),
                  TextFormField(
                      controller: _gmailTEController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(hintText: 'Gmail'),
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return 'Enter a valid email address';
                        }
                        return null;
                      }),
                  SizedBox(height: 24),
                  GetBuilder<ForgotPasswordGmailController>(
                      builder: (controller) {
                    return ElevatedButton(
                      onPressed: controller.inProgress == true
                          ? _verifygmailButton
                          : null,
                      child: controller.inProgress == true
                          ? Icon(
                              Icons.arrow_circle_right_outlined,
                              color: Colors.white,
                              size: 24,
                            )
                          : CircularProgressIndicator(
                              color: AppColors.themColor,
                            ),
                    );
                  }),
                  SizedBox(height: 48),
                  Center(
                    child: buildSignUpSection(),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildSignUpSection() {
    final textThem = Theme.of(context).textTheme;

    return RichText(
      text: TextSpan(
        text: "Have account? ",
        style: textThem.labelLarge,
        children: [
          TextSpan(
            text: "Sign up",
            style: TextStyle(
              color: AppColors.themColor,
              fontFamily: 'poppins',
              fontWeight: FontWeight.w600,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Get.back();
              },
          )
        ],
      ),
    );
  }

  void _verifygmailButton() {
    if (_formKey.currentState!.validate()) {
      _verifyGmail();
    }
  }

  Future<void> _verifyGmail() async {
    bool isSuccess = await _forgotPasswordGmailController
        .verifyGmail(_gmailTEController.text.trim());

    if (isSuccess) {
      Get.offNamed(ForgorPasswordOtpVerification.name,
          arguments: _gmailTEController.text.trim());
      _gmailTEController.clear();
    } else {
      showSnackBarMessage(
          context, _forgotPasswordGmailController.errorMessage, false);
    }
  }

  @override
  void dispose() {
    _gmailTEController.dispose();
    super.dispose();
  }
}
