import 'package:a7lanpopo/features/registeration/registform.dart';
import 'package:a7lanpopo/features/screens/login/login.dart';

import 'package:a7lanpopo/features/screens/onboarding/ui.dart';
import 'package:a7lanpopo/features/screens/splash/splash.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String splashScreen = '/splashScreen';
  static const String onBoardingScreen = '/onBoardingScreen';
  static const String register = '/registerScreen';
  static const String login = '/login';
  static const String mainPage = '/mainPage';
}

class AppRoutes {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashScreen:
        return MaterialPageRoute(builder: (context) => const SplashScreen());

      case Routes.onBoardingScreen:
        return MaterialPageRoute(builder: (context) => const UiOnBoarding());

      case Routes.register:
        return MaterialPageRoute(builder: (context) => const Registration());

      case Routes.login:
        return MaterialPageRoute(builder: (context) => const Login());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No Routes${settings.name}'),
            ),
          ),
        );
    }
  }
}
