import 'package:a7lanpopo/features/constant.dart';
import 'package:a7lanpopo/features/registeration/regist.dart';
import 'package:a7lanpopo/features/screens/login/login.dart';

import 'package:a7lanpopo/features/screens/onboarding/ui.dart';
import 'package:a7lanpopo/features/screens/splash/splash.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Constant.splashScreen:
        return MaterialPageRoute(builder: (context) => const SplashScreen());

      case Constant.onBoardingScreen:
        return MaterialPageRoute(builder: (context) => const UiOnBoarding());

      case Constant.register:
        return MaterialPageRoute(builder: (context) => const Registration());

      case Constant.login:
        return MaterialPageRoute(builder: (context) => const Login());
    }
    return null;
  }
}
