import 'package:flutter/material.dart';
import 'package:vitally/screens/authentication/forgotPassword.dart';
import 'package:vitally/screens/authentication/signUp.dart';
import 'package:vitally/screens/authentication/signin.dart';
import 'package:vitally/screens/dashboard/dashboard.dart';
import 'package:vitally/screens/dashboard/profile/settings/settings.dart';
import 'package:vitally/screens/offline/offline.dart';
import 'package:vitally/screens/onBoarding/onBoardingScreen.dart';
import 'package:vitally/screens/registration/getToKnowYourself.dart';
import 'package:vitally/screens/registration/goalSelection.dart';
import 'package:vitally/screens/registration/helpUsKnowYouBetter.dart';
import 'package:vitally/screens/registration/preview.dart';
import 'package:vitally/screens/registration/targetWeight.dart';
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

      case '/helpUsKnowYouBetter':
        return EnterExitRoute(
          enterPage: HelpUsKnowYouBetter(),
        );

      case '/getToKnowYourself':
        return EnterExitRoute(
          enterPage: GetToKnowYourself(),
        );

      case '/goalSelection':
        return EnterExitRoute(
          enterPage: GoalSelection(),
        );

      case '/targetWeight':
        return EnterExitRoute(
          enterPage: TargetWeight(),
        );

      case '/planReview':
        return EnterExitRoute(
          enterPage: GoalPreview(),
        );

      case '/offline':
        return EnterExitRoute(
          enterPage: OfflineScreen(),
        );

      case '/dashboard':
        return EnterExitRoute(
          enterPage: Dashboard(),
        );

      case '/settings':
        return EnterExitRoute(
          enterPage: SettingsScreen(),
        );

      default:
        return MaterialPageRoute(builder: (context) {
          return SplashScreen();
        });
    }
  }
}
