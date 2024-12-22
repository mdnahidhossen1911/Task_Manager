import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/ui/utils/app_colors.dart';

import '../widgets/task_widgets.dart';
import 'screens.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  static const String name = '/SignInScreen';

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController _gmailTEController = TextEditingController();
  TextEditingController _passwordTEController = TextEditingController();

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
                  'Get Started with',
                  style: textThem.titleLarge,
                ),
                SizedBox(height: 24),
                TextField(
                  controller: _gmailTEController,
                  decoration: InputDecoration(hintText: 'Gmail'),
                ),
                SizedBox(height: 8),
                TextField(
                  controller: _passwordTEController,
                  obscureText: true,
                  decoration: InputDecoration(hintText: 'Password'),
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
                  child: Column(
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(
                              context, ForgorPasswordEmailVerification.name);
                        },
                        child: Text('Forgot Password'),
                      ),
                      buildSignUpSection(),
                    ],
                  ),
                ),
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
        text: "Don't have an Acount? ",
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
                Navigator.pushNamed(context, SignUpScreen.name);
              },
          )
        ],
      ),
    );
  }
}
