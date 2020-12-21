import 'package:flutter/material.dart';
import 'package:vitally/screens/authentication/forgotPassword.dart';
import 'package:vitally/screens/authentication/signUp.dart';
import 'package:vitally/screens/authentication/signin.dart';
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

      case '/signup':
        return EnterExitRoute(
          enterPage: SignUpScreen(),
        );

      case '/signin':
        return EnterExitRoute(
          enterPage: SignInScreen(),
        );

      case '/forgotPassword':
        return EnterExitRoute(
          enterPage: ForgotPasswordScreen(),
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
