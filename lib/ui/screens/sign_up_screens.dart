import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/ui/controller/sign_in_controller.dart';
import 'package:task_manager/ui/controller/sign_up_controller.dart';
import 'package:task_manager/ui/utils/app_colors.dart';
import 'package:task_manager/ui/widgets/snack_bar_massage.dart';

import '../widgets/task_widgets.dart';
import 'main_bottom_nav_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  static const String name = '/SignUpScreen';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _gmailTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final SignUpController _signUpController = Get.find<SignUpController>();

  bool signUpInProgress = true;

  @override
  Widget build(BuildContext context) {
    final textThem = Theme.of(context).textTheme;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BackgroundScreen(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 88),
                  Text(
                    'Join With Us',
                    style: textThem.headlineMedium,
                  ),
                  SizedBox(height: 24),
                  TextFormField(
                    controller: _gmailTEController,
                    keyboardType: TextInputType.emailAddress,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(hintText: 'Gmail'),
                    validator: (value) {
                      if (value?.trim().isEmpty ?? true) {
                        return 'Enter your gmail';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 8),
                  TextFormField(
                      controller: _firstNameTEController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(hintText: 'First Name'),
                      validator: (value) {
                        if (value?.trim().isEmpty ?? true) {
                          return 'Enter your first Name';
                        }
                        return null;
                      }),
                  SizedBox(height: 8),
                  TextFormField(
                      controller: _lastNameTEController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(hintText: 'Last Name'),
                      validator: (value) {
                        if (value?.trim().isEmpty ?? true) {
                          return 'Enter your last Name';
                        }
                        return null;
                      }),
                  SizedBox(height: 8),
                  TextFormField(
                      controller: _mobileTEController,
                      keyboardType: TextInputType.number,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(hintText: 'Mobile'),
                      validator: (value) {
                        if (value?.trim().isEmpty ?? true) {
                          return 'Enter your mobile';
                        }
                        return null;
                      }),
                  SizedBox(height: 8),
                  TextFormField(
                    controller: _passwordTEController,
                    obscureText: true,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(hintText: 'Password'),
                    validator: (value) {
                      if (value?.trim().isEmpty ?? true) {
                        return 'Enter your password';
                      }
                      if (value!.length < 6) {
                        return 'Enter a password more than 6 letters';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 24),
                  GetBuilder<SignUpController>(builder: (controller) {
                    return ElevatedButton(
                      onPressed: controller.inProgress == true
                          ? _ontabSignupButton
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

  void _ontabSignupButton() {
    if (_formKey.currentState!.validate()) {
      signUpInProgress = false;
      setState(() {});
      _registation();
    }
  }

  Future<void> _registation() async {
    Map<String, dynamic> requestBody = {
      "email": _gmailTEController.text.trim(),
      "firstName": _firstNameTEController.text.trim(),
      "lastName": _lastNameTEController.text.trim(),
      "mobile": _mobileTEController.text.trim(),
      "password": _passwordTEController.text,
      "photo": ""
    };

    bool isSucces = await _signUpController.registation(requestBody);

    if (isSucces) {
      showSnackBarMessage(context, 'Registration successful!', true);
      Future.delayed(
        Duration(milliseconds: 500),
        () => _signIn(),
      );
    } else {
      if (_signUpController.errorMessage ==
          'Already created an account using this email.') {
        showSnackBarMessage(
            context, 'Already created an account using this email.', false);
        _gmailTEController.clear();
      } else {
        showSnackBarMessage(context, _signUpController.errorMessage!, false);
      }
    }
    setState(() {});
  }

  Future<void> _signIn() async {
    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: SizedBox(
            height: 50,
            width: 50,
            child: CircularProgressIndicator(),
          ),
        );
      },
    );

    bool isSucess = await Get.find<SignInController>()
        .signIn(_gmailTEController.text.trim(), _passwordTEController.text);

    if (isSucess) {
      _clearTextField();
      Get.offNamedUntil(
        MainBottomNavScreen.name,
        (route) => false,
      );
    } else {
      Get.back();
      Get.back();
    }
  }

  void _clearTextField() {
    _gmailTEController.clear();
    _firstNameTEController.clear();
    _lastNameTEController.clear();
    _mobileTEController.clear();
    _passwordTEController.clear();
  }

  @override
  void dispose() {
    _gmailTEController.dispose();
    _firstNameTEController.dispose();
    _lastNameTEController.dispose();
    _mobileTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }
}
