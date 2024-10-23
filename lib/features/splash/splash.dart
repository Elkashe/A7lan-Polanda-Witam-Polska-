

import 'dart:async';

import 'package:a7lanpopo/features/routes.dart';
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
      Navigator.pushNamed(context, Routes.onBoardingScreen);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Image.asset('assets/images/architecture-poland.jpg', fit: BoxFit.cover,);
  }
}