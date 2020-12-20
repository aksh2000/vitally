import 'package:flutter/material.dart';
import 'package:vitally/screens/onBoarding/onBoardingScreen.dart';
import 'package:vitally/screens/splashScreen/splashScreen.dart';
import 'package:vitally/utilities/navigation/pageTransitionAnimation.dart';

class RouteGenerator {
  Route<dynamic> generateRoute(RouteSettings settings) {
    final List<Object> arguments = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) {
          return SplashScreen();
        });

      case '/onBoarding':
        return EnterExitRoute(
          enterPage: OnBoardingScreen(),
        );

      case '/login':
        return EnterExitRoute(
          enterPage: OnBoardingScreen(),
        );

      case '/dashboard':
        return EnterExitRoute(
          enterPage: OnBoardingScreen(),
        );

      default:
        return MaterialPageRoute(builder: (context) {
          return SplashScreen();
        });
    }
  }
}
