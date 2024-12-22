import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/ui/utils/app_colors.dart';

import '../widgets/task_widgets.dart';

class ForgorPasswordEmailVerification extends StatefulWidget {
  const ForgorPasswordEmailVerification({super.key});

  static const String name = '/ForgorPassword/EmailVerification';

  @override
  State<ForgorPasswordEmailVerification> createState() =>
      _ForgorPasswordEmailVerificationState();
}

class _ForgorPasswordEmailVerificationState
    extends State<ForgorPasswordEmailVerification> {
  TextEditingController _gmailTEController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final textThem = Theme.of(context).textTheme;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BackgroundScreen(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 88),
                Text(
                  'Your Email Address',
                  style: textThem.titleLarge,
                ),
                Text(
                  'A 6 digit verification pin will send to your email address',
                  style: TextStyle(color: Colors.black38),
                ),
                SizedBox(height: 24),
                TextField(
                  controller: _gmailTEController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(hintText: 'Gmail'),
                ),
                SizedBox(height: 24),
                ElevatedButton(
                  child: Icon(
                    Icons.arrow_circle_right_outlined,
                    color: Colors.white,
                    size: 24,
                  ),
                  onPressed: () {},
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
    );
  }

  Widget buildSignUpSection() {
    return RichText(
      text: TextSpan(
        text: "Have account? ",
        style: TextStyle(
          color: Colors.black87,
          fontWeight: FontWeight.w600,
        ),
        children: [
          TextSpan(
            text: "Sign up",
            style: TextStyle(
              color: AppColors.themColor,
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
}
