import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vitally/utilities/appConfig/appConfig.dart';

// ignore: must_be_immutable
class SplashScreen extends StatelessWidget {
  AppConfig appConfig;
  @override
  Widget build(BuildContext context) {
    appConfig = AppConfig(context);
    backgroundTask(context);
    return Scaffold(
      body: Container(
        height: appConfig.responsive.heightBasedOnPercentage(100),
        width: appConfig.responsive.widthBasedOnPercentage(100),
        alignment: Alignment.center,
        child: logo,
      ),
    );
  }

  Widget get logo {
    return SizedBox(
      height: appConfig.responsive.heightBasedOnPercentage(35),
      child: Image.asset("assets/logo/vitallyLogo.png"),
    );
  }

  Future backgroundTask(BuildContext context) {
    return Future.delayed(Duration(seconds: 2)).whenComplete(() async {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();

      final bool isAppLaunchingForTheFirstTime =
          sharedPreferences.getBool("isAppLaunchingForTheFirstTime") ?? true;
      final bool userExists = sharedPreferences.getBool("userExists") ?? false;

      final bool appIsInTesting = true;

      if (isAppLaunchingForTheFirstTime && !appIsInTesting) {
        sharedPreferences.setBool("isAppLaunchingForTheFirstTime", false);
      }

      switch (isAppLaunchingForTheFirstTime) {
        case true:
          Navigator.pushReplacementNamed(context, '/onBoarding');
          break;
        case false:
          if (userExists) {
            final String user = sharedPreferences.getString("user") ?? "";
            Navigator.pushReplacementNamed(
              context,
              '/dashboard',
              arguments: [user],
            );
          } else {
            Navigator.pushReplacementNamed(context, '/signin');
          }
          break;
      }
    });
  }
}
