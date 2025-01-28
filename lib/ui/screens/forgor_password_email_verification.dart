import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/data/utils/urls.dart';
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
  bool _InProgress = true;

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
                  ElevatedButton(
                    onPressed: _InProgress == true ? _verifygmailButton : null,
                    child: _InProgress == true
                        ? Icon(
                            Icons.arrow_circle_right_outlined,
                            color: Colors.white,
                            size: 24,
                          )
                        : CircularProgressIndicator(
                            color: AppColors.themColor,
                          ),
                  ),
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
                Navigator.pop(context);
              },
          )
        ],
      ),
    );
  }

  void _verifygmailButton() {
    if (_formKey.currentState!.validate()) {
      _InProgress = false;
      setState(() {});
      _verifyGmail();
    }
  }

  Future<void> _verifyGmail() async {
    NetworkResponse response = await NetworkCaller.getRequest(
        url: Urls.gmailVerify(_gmailTEController.text.trim()));
    _InProgress = true;
    if (response.isSuccess) {
      if (response.responseData!['status'] == 'fail') {
        showSnackBarMessage(context, "No User Found", false);
      } else {
        Navigator.pushReplacementNamed(
          context,
          ForgorPasswordOtpVerification.name,
          arguments: _gmailTEController.text.trim(),
        );
      }
    } else {
      showSnackBarMessage(context, response.errorMessage, false);
    }

    setState(() {});
  }

  @override
  void dispose() {
    _gmailTEController.dispose();
    super.dispose();
  }
}
