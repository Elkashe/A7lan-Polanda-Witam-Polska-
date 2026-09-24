

import 'dart:async';

import 'package:a7lanpopo/core/sharedpref/shared.dart';
import 'package:a7lanpopo/features/constant.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkUserSession();
  }

  Future<void> _checkUserSession() async {
    // Keep splash screen visible for a short time
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    // Check if Supabase already has a logged-in session
    final session = Supabase.instance.client.auth.currentSession;

    if (session != null) {
      // User is already logged in -> go directly to Home
      Navigator.pushNamedAndRemoveUntil(
        context,
        Constant.mainPage,
        (route) => false,
      );
      return;
    }

    // No active session -> check if onboarding was completed
    final onboardingCompleted = CacheHelper.getBool('onboarding');

    if (!mounted) return;

    if (onboardingCompleted) {
      // User has already seen onboarding
      Navigator.pushReplacementNamed(
        context,
        Constant.register,
      );
    } else {
      // First time opening the app
      Navigator.pushReplacementNamed(
        context,
        Constant.onBoardingScreen,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Image.asset(
          'assets/images/architecture-poland.jpg',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}