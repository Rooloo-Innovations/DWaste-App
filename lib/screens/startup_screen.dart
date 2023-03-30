import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:dwaste/screens/home_screen.dart';
import 'package:dwaste/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StartupScreen extends StatefulWidget {
  const StartupScreen({Key? key}) : super(key: key);

  @override
  State<StartupScreen> createState() => _StartupScreenState();
}

class _StartupScreenState extends State<StartupScreen> {
  String? accessToken;

  @override
  void initState() {
    // TODO: implement initState
    checkAccessToken();

    super.initState();
  }

  void checkAccessToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // await prefs.setString('access_token', '');
    String? token = prefs.getString('access_token');
    setState(() {
      accessToken = token;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSplashScreen.withScreenFunction(
        splash: 'assets/images/logo.png',
        screenFunction: () async {
          if (accessToken == null || accessToken == '') {
            return LoginScreen();
          } else {
            // Navigate to the next screen
            return HomeScreen();
          }
        },
      ),
    );
    // return LoginScreen();
  }
}
