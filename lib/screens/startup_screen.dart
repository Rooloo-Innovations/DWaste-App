import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:dwaste/models/app_colors.dart';
import 'package:dwaste/screens/home_screen.dart';
import 'package:dwaste/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loader_overlay/loader_overlay.dart';
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
            return const LoaderOverlay(
                useDefaultLoading: false,
                overlayWidget: Center(
                  child: SpinKitFadingCube(
                    color: AppColors.green,
                    size: 50.0,
                  ),
                ),
                child: HomeScreen());
          }
        },
      ),
    );
    // return LoginScreen();
  }
}
