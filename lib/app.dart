import 'package:flutter/material.dart';
import 'package:task_manager/ui/screens/add_new_task_screen.dart';
import 'package:task_manager/ui/screens/forgor_password_email_verification.dart';
import 'package:task_manager/ui/screens/forgot_password_otp_verification.dart';
import 'package:task_manager/ui/screens/main_bottom_nav_screen.dart';
import 'package:task_manager/ui/screens/recovary_password_screen.dart';
import 'package:task_manager/ui/screens/sign_in_screen.dart';
import 'package:task_manager/ui/screens/sign_up_screens.dart';
import 'package:task_manager/ui/screens/splash_screen.dart';
import 'package:task_manager/ui/screens/update_profile_screen.dart';
import 'package:task_manager/ui/utils/app_colors.dart';

class TaskManagerApp extends StatelessWidget {
  const TaskManagerApp({super.key});

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

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
          final String gmail = settings.arguments as String;
          widget = ForgorPasswordOtpVerification(
            gmail: gmail,
          );
        } else if (settings.name == RecovaryPasswordScreen.name) {
          final Map emailAndOtp = settings.arguments as Map;
          widget = RecovaryPasswordScreen(
            emailAndOtp: emailAndOtp,
          );
        } else if (settings.name == MainBottomNavScreen.name) {
          widget = const MainBottomNavScreen();
        } else if (settings.name == AddNewTaskScreen.name) {
          widget = const AddNewTaskScreen();
        } else if (settings.name == UpdateProfileScreen.name) {
          widget = const UpdateProfileScreen();
        }
        return MaterialPageRoute(
          builder: (context) => widget,
        );
      },
    );
  }
}
