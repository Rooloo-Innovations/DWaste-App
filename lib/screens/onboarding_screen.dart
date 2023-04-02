import 'package:dwaste/models/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 20.0),
        child: OnBoardingSlider(
          headerBackgroundColor: Colors.white,
          controllerColor: AppColors.green,
          finishButtonColor: AppColors.green,
          finishButtonText: 'Let’s Get Started',
          skipTextButton: const Text('Skip'),
          trailing: const Text('Login'),
          background: [
            // Image.asset('assets/images/onboarding/onboarding_1.png'),
            // Image.asset('assets/images/onboarding/onboarding_2.png'),
            Container(),
            Container(),
            Container()
          ],
          totalPage: 3,
          speed: 1.8,
          pageBodies: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: Column(
                children: <Widget>[
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(colors: [
                        Color.fromRGBO(223, 247, 250, 1),
                        Color.fromRGBO(186, 233, 239, 1),
                      ]),
                    ),
                    height: 40.0,
                  ),
                  Stack(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(colors: [
                            Color.fromRGBO(223, 247, 250, 1),
                            Color.fromRGBO(186, 233, 239, 1),
                          ]),
                        ),
                        height: 200.0,
                      ),
                      const Image(
                        image: AssetImage(
                            'assets/images/onboarding/onboarding1.png'),
                        width: double.infinity,
                        fit: BoxFit.fill,
                      )
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Protect Our Earth',
                      style: TextStyle(
                          fontSize: 24.0,
                          color: Color(0xff35B228),
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Text(
                      'Make the earth a map to real life. Life can be better if it is in the right hands and free from air and factory pollution.',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Color(0xff88938D),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),

            // Onboarding second screen

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: Column(
                children: <Widget>[
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(colors: [
                        Color.fromRGBO(186, 233, 239, 1),
                        Color.fromRGBO(203, 239, 244, 1),
                      ]),
                    ),
                    height: 30.0,
                  ),
                  Stack(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(colors: [
                            Color.fromRGBO(186, 233, 239, 1),
                            Color.fromRGBO(203, 239, 244, 1),
                          ]),
                        ),
                        height: 200.0,
                      ),
                      const Image(
                        image: AssetImage(
                            'assets/images/onboarding/onboarding2.png'),
                        width: double.infinity,
                        fit: BoxFit.fill,
                      )
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Planting One Tree',
                      style: TextStyle(
                          fontSize: 24.0,
                          color: Color(0xff35B228),
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Text(
                      'Make our Earth grow with many plants starting from planting one tree with various types of plants on our earth.',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Color(0xff88938D),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),

            // Onboarding third screen

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: Column(
                children: <Widget>[
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(colors: [
                        Color.fromRGBO(223, 247, 250, 1),
                        Color.fromRGBO(186, 233, 239, 1),
                      ]),
                    ),
                    height: 30.0,
                  ),
                  Stack(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(colors: [
                            Color.fromRGBO(223, 247, 250, 1),
                            Color.fromRGBO(186, 233, 239, 1),
                          ]),
                        ),
                        height: 200.0,
                      ),
                      const Image(
                        image: AssetImage(
                            'assets/images/onboarding/onboarding3.png'),
                        width: double.infinity,
                        fit: BoxFit.fill,
                      )
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Keep Plant Health',
                      style: TextStyle(
                          fontSize: 24.0,
                          color: Color(0xff35B228),
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Text(
                      'Through plants that are fertile and growing on earth we will produce extraordinary benefits and produce clean and healthy air.',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Color(0xff88938D),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
