

import 'package:flutter/material.dart';

class Constant {
  static const String splashScreen = 'SplashScreen';
  static const String onBoardingScreen = 'OnBoardingScreen';
  static const String register = 'RegisterScreen';
  static const String login = 'Login';
  static const String mainPage = 'MainPage';
}

var pageController = PageController();

var formKey = GlobalKey<FormState>();

 TextEditingController userController = TextEditingController();
  TextEditingController sureController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController repassController = TextEditingController();
