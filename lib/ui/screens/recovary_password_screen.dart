import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/data/utils/urls.dart';
import 'package:task_manager/ui/screens/sign_in_screen.dart';
import 'package:task_manager/ui/utils/app_colors.dart';
import 'package:task_manager/ui/widgets/snack_bar_massage.dart';

import '../widgets/task_widgets.dart';

class RecovaryPasswordScreen extends StatefulWidget {
  final Map emailAndOtp;
  const RecovaryPasswordScreen({
    super.key,
    required this.emailAndOtp,
  });

  static const String name = '/Forgor-Password/Recovary-password';

  @override
  State<RecovaryPasswordScreen> createState() => _RecovaryPasswordScreenState();
}

class _RecovaryPasswordScreenState extends State<RecovaryPasswordScreen> {
  final TextEditingController _passTEController = TextEditingController();
  final TextEditingController _confirmpassTEController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _inProgress = true;

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
                    'Set Password',
                    style: textThem.headlineMedium,
                  ),
                  Text(
                    'Minimum length password 6 character with Latter and number combination ',
                    style: textThem.bodyMedium,
                  ),
                  SizedBox(height: 24),
                  TextFormField(
                      controller: _passTEController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(hintText: 'Password'),
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return 'Enter your password';
                        }
                        if (value!.length < 6) {
                          return 'Enter a password more than 6 letters';
                        }
                        return null;
                      }),
                  SizedBox(height: 12),
                  TextFormField(
                      controller: _confirmpassTEController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(hintText: 'Confirm Password'),
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return 'Enter your Confirm password';
                        }
                        if (value!.length < 6) {
                          return 'Enter a password more than 6 letters';
                        }
                        return null;
                      }),
                  SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: _inProgress == true ? _setPassButton : null,
                    child: _inProgress == true
                        ? Text('Confirm')
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

  void _setPassButton() {
    if (_formKey.currentState!.validate()) {
      if (_passTEController.text == _confirmpassTEController.text) {
        _inProgress = false;
        setState(() {});
        recovaryPassword();
      } else {
        showSnackBarMessage(context, "No Match Password", false);
        _passTEController.clear();
        _confirmpassTEController.clear();
      }
    }
  }

  Future<void> recovaryPassword() async {
    Map<String, dynamic> recponseBody = {
      "email": widget.emailAndOtp['gmail'],
      "OTP": widget.emailAndOtp['otp'],
      "password": _confirmpassTEController.text
    };
    NetworkResponse response = await NetworkCaller.postRequest(
        url: Urls.recoverResetPass, body: recponseBody);
    if (response.isSuccess) {
      showSnackBarMessage(context, "Password recovary success", true);
      Future.delayed(Duration(seconds: 1));
      Navigator.pushNamedAndRemoveUntil(
        context,
        SignInScreen.name,
        (route) => false,
      );
    } else {
      showSnackBarMessage(context, response.errorMessage, false);
    }
  }

  @override
  void dispose() {
    _passTEController.dispose();
    _confirmpassTEController.dispose();
    super.dispose();
  }
}
