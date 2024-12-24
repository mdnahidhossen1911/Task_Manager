import 'package:flutter/material.dart';
import 'package:task_manager/ui/screens/forgot_password_otp_verification.dart';
import 'package:task_manager/ui/screens/screens.dart';
import 'package:task_manager/ui/utils/app_colors.dart';

class TaskManagerApp extends StatelessWidget {
  const TaskManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: AppColors.themColor,
        textTheme: TextTheme(
          headlineMedium: TextStyle(
            fontSize: 28,
            fontFamily: 'poppins',
            fontWeight: FontWeight.w600,
            color: Color(0xff2e374f),
          ),
          bodyMedium: TextStyle(
            fontFamily: 'roboto',
            color: Color(0xff989898),
          ),
          labelSmall: TextStyle(
            fontSize: 11,
            fontFamily: 'poppins',
            fontWeight: FontWeight.w400,
            color: Color(0xff5f5f5f),
          ),
          labelLarge: TextStyle(
            fontSize: 13,
            fontFamily: 'poppins',
            fontWeight: FontWeight.w600,
            color: Color(0xff2e374f),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.themColor,
            foregroundColor: Colors.white,
            fixedSize: Size.fromWidth(double.maxFinite),
            textStyle: TextStyle(fontSize: 16),
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          hintStyle: TextStyle(
            fontSize: 11,
            fontFamily: 'roboto',
            fontWeight: FontWeight.w300,
            color: Color(0xffc0c0c0),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(8),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      initialRoute: '/',
      onGenerateRoute: (settings) {
        late Widget widget;
        if (settings.name == SplashScreen.name) {
          widget = const SplashScreen();
        } else if (settings.name == SignInScreen.name) {
          widget = const SignInScreen();
        } else if (settings.name == SignUpScreen.name) {
          widget = const SignUpScreen();
        } else if (settings.name == ForgorPasswordEmailVerification.name) {
          widget = const ForgorPasswordEmailVerification();
        } else if (settings.name == ForgorPasswordOtpVerification.name) {
          widget = const ForgorPasswordOtpVerification();
        }
        return MaterialPageRoute(
          builder: (context) => widget,
        );
      },
    );
  }
}
