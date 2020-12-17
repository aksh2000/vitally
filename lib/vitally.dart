import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vitally/utilities/appConfig/appColors.dart';
import 'package:vitally/utilities/appConfig/appTheme.dart';
import 'package:vitally/utilities/navigation/routes.dart';

class Vitally extends StatefulWidget {
  Vitally(
      {@required this.sharedPreferences,
      @required this.isAppLaunchingForTheFirstTime});
  final SharedPreferences sharedPreferences;
  final bool isAppLaunchingForTheFirstTime;
  final RouteGenerator routes = RouteGenerator();
  @override
  _VitallyState createState() => _VitallyState();
}

class _VitallyState extends State<Vitally> {
  AppTheme appTheme;
  bool userExists;
  String userId;
  bool isAppLaunchingForTheFirstTime;
  final AppColors appColors = AppColors();

  @override
  void initState() {
    userExists = widget.sharedPreferences.getBool("userExists") ?? false;
    userId = widget.sharedPreferences.getString("userId") ?? null;
    isAppLaunchingForTheFirstTime = widget.isAppLaunchingForTheFirstTime;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    appTheme = AppTheme(appColors: this.appColors, context: this.context);
    return MaterialApp(
      key: Key("VitallyApp"),
      debugShowCheckedModeBanner: false,
      theme: appTheme.themeData,
      title: "Vitally",
      color: appColors.white,
      onGenerateRoute: widget.routes.generateRoute,
      initialRoute: initialRoute,
    );
  }

  String get initialRoute {
    switch (isAppLaunchingForTheFirstTime) {
      case true:
        return '/onBoarding'; //should return onBoarding Page

      case false:
        if (userExists) {
          return '/dashboard'; // should return dashboard screen
        } else {
          return '/login'; // should return SingIn Screen
        }
        break;

      default:
        return '/login'; // should return signIn Screen

    }
  }
}
