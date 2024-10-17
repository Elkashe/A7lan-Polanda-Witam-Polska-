

import 'dart:async';

import 'package:a7lanpopo/core/sharedpref/shared.dart';
import 'package:a7lanpopo/features/constant.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  @override
  void initState(){
    super.initState();

    Timer(const Duration(seconds: 3), (){
      Navigator.pushNamed(context, Constant.onBoardingScreen);

       WidgetsBinding.instance.addPostFrameCallback((_) {
      
       bool onboarding = 
      CacheHelper.getBool('onboarding');
       if (onboarding) {
      Navigator.pushReplacementNamed(context, Constant.register);
       }
    });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Image.asset('assets/images/architecture-poland.jpg', fit: BoxFit.cover,);
  }
}