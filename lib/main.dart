import 'dart:async';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lms_parent_app/login/login_screen.dart';
import 'package:lms_parent_app/pages/category_page.dart';
import 'package:lms_parent_app/pages/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String info = '';
  void userInfo() async {
    SharedPreferences userPrefs = await SharedPreferences.getInstance();
    setState(() {
      info = userPrefs.getString('userInfo')!;
    });
    print(info);
  }

  @override
  void initState() {
    super.initState();
    userInfo();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AnimatedSplashScreen(
        duration: 3000,
        splash: Image.asset(
          'assets/kyc.png',
          height: 200,
          width: 300,
        ),
        nextScreen: info == '' ? const LoginScreen() : CategoryPage(id: info),
        splashIconSize: 400,
        splashTransition: SplashTransition.sizeTransition,
      ),
    );
  }
}
