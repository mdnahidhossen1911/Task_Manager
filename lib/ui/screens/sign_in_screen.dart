import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/ui/screens/sign_up_screens.dart';
import 'package:task_manager/ui/utils/app_colors.dart';
import 'package:task_manager/ui/widgets/snack_bar_massage.dart';

import '../../data/models/user_model.dart';
import '../../data/services/network_caller.dart';
import '../../data/utils/urls.dart';
import '../controller/auth_controller.dart';
import '../widgets/task_widgets.dart';
import 'forgor_password_email_verification.dart';
import 'main_bottom_nav_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  static const String name = '/SignInScreen';

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _gmailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _SignInFormKey = GlobalKey<FormState>();
  bool signInProgress = true;

  @override
  Widget build(BuildContext context) {
    final textThem = Theme.of(context).textTheme;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BackgroundScreen(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Form(
              key: _SignInFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 128),
                  Text(
                    'Get Started with',
                    style: textThem.headlineMedium,
                  ),
                  SizedBox(height: 24),
                  TextFormField(
                      controller: _gmailTEController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(hintText: 'Gmail'),
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return 'Enter a valid email address';
                        }
                        return null;
                      }),
                  SizedBox(height: 8),
                  TextFormField(
                    controller: _passwordTEController,
                    obscureText: true,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(hintText: 'Password'),
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return 'Enter your valid password';
                      }
                      if (value!.length < 6) {
                        return 'Enter a password more than 6 letters';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 24),
                  ElevatedButton(
                    onPressed:
                        signInProgress == true ? _ontabSignINButton : null,
                    child: signInProgress == true
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
                    child: Column(
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              ForgorPasswordEmailVerification.name,
                            );
                          },
                          child: Text(
                            'Forgot Password?',
                            style: textThem.labelSmall,
                          ),
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
      ),
    );
  }

  Widget buildSignUpSection() {
    final textThem = Theme.of(context).textTheme;

    return RichText(
      text: TextSpan(
        text: "Don't have an Acount? ",
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
                Navigator.pushNamed(context, SignUpScreen.name);
              },
          )
        ],
      ),
    );
  }

  void _ontabSignINButton() {
    if (_SignInFormKey.currentState!.validate()) {
      signInProgress = false;
      setState(() {});
      _signIn();
    }
  }

  Future<void> _signIn() async {
    Map<String, dynamic> requestBody = {
      "email": _gmailTEController.text.trim(),
      "password": _passwordTEController.text,
    };

    NetworkResponse response = await NetworkCaller.postRequest(
      url: Urls.loginUrl,
      body: requestBody,
    );
    signInProgress = true;
    setState(() {});
    if (response.isSuccess) {
      String token = response.responseData!['token'];
      UserModel userModel = UserModel.fromJson(response.responseData!['data']);
      await AuthController.saveUserData(token, userModel);
      Navigator.pushNamedAndRemoveUntil(
        context,
        MainBottomNavScreen.name,
        (route) => false,
      );
    } else {
      showSnackBarMessage(
          context, 'Email/Password is invalid! Try again.', false);
    }
  }
}
