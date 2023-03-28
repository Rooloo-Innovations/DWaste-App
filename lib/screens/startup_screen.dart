import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:dwaste/screens/login_screen.dart';
import 'package:flutter/material.dart';

class StartupScreen extends StatefulWidget {
  const StartupScreen({Key? key}) : super(key: key);

  @override
  State<StartupScreen> createState() => _StartupScreenState();
}

class _StartupScreenState extends State<StartupScreen> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
        splash: 'assets/images/logo.png', nextScreen: LoginScreen());
  }
}
