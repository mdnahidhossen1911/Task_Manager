import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_manager/ui/screens/core/screens.dart';
import 'package:task_manager/ui/utils/app_colors.dart';

import '../widgets/task_widgets.dart';

class ForgorPasswordOtpVerification extends StatefulWidget {
  const ForgorPasswordOtpVerification({super.key});

  static const String name = '/Forgor-Password/OTP-Verification';

  @override
  State<ForgorPasswordOtpVerification> createState() =>
      _ForgorPasswordOtpVerificationState();
}

class _ForgorPasswordOtpVerificationState
    extends State<ForgorPasswordOtpVerification> {
  TextEditingController _otpTEController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final textThem = Theme.of(context).textTheme;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BackgroundScreen(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(48),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 96),
                Text(
                  'PIN Verification',
                  style: textThem.headlineMedium,
                ),
                Text(
                  'A 6 digit verification pin will send to your email address',
                  style: textThem.bodyMedium,
                ),
                SizedBox(height: 24),
                _buildPinCodeTextField(),
                SizedBox(height: 24),
                ElevatedButton(
                  child: Icon(
                    Icons.arrow_circle_right_outlined,
                    color: Colors.white,
                    size: 24,
                  ),
                  onPressed: () {},
                ),
                SizedBox(height: 36),
                Center(
                  child: buildSignUpSection(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPinCodeTextField() {
    return PinCodeTextField(
      length: 6,
      animationType: AnimationType.fade,
      keyboardType: TextInputType.number,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(5),
        fieldHeight: 50,
        fieldWidth: 50,
        activeFillColor: Colors.white,
        selectedFillColor: AppColors.themColor,
        inactiveFillColor: Colors.white,
        activeColor: AppColors.themColor,
        selectedColor: AppColors.themColor,
        inactiveColor: Colors.white,
      ),
      animationDuration: const Duration(milliseconds: 300),
      backgroundColor: Colors.transparent,
      enableActiveFill: true,
      controller: _otpTEController,
      appContext: context,
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
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  SignInScreen.name,
                  (route) => false,
                );
              },
          )
        ],
      ),
    );
  }
}
