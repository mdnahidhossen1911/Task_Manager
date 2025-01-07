import 'package:flutter/material.dart';
import 'package:task_manager/ui/screens/core/screens.dart';

import '../widgets/task_widgets.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const String name = '/';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNextScreen();
  }

  Future<void> getNextScreen() {
    return Future.delayed(
      const Duration(seconds: 3),
      () {
        Navigator.pushReplacementNamed(context, SignInScreen.name);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundScreen(
        child: Center(
          child: AppLogo(),
        ),
      ),
    );
  }
}
