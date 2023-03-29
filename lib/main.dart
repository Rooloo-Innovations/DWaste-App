import 'package:dwaste/screens/home_screen.dart';
import 'package:dwaste/screens/login_screen.dart';
import 'package:dwaste/screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'models/app_colors.dart';

void main() async {
  await initHiveForFlutter();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dwaste',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Dwaste'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Inter',
        appBarTheme: const AppBarTheme(
          color: AppColors.backgroundColor,
          elevation: 0.0,
        ),
        primaryColor: AppColors.yellow,
      ),
      initialRoute: '/home',
      routes: {
        '/': (context) => CreateAccountScreen(),
        '/login': (context) => LoginScreen(),
        '/register': (context) => CreateAccountScreen(),
        '/home': (context) => HomeScreen(),
      },
    );
  }
}
