import 'package:flutter/material.dart';
import 'package:vitally/utilities/appConfig/appColors.dart';
import 'package:vitally/utilities/appConfig/responsive.dart';

class AppTheme {
  final AppColors appColors;
  ThemeData themeData;
  Responsive responsive;

  AppTheme({@required this.appColors}) {
    this.themeData = ThemeData(
      fontFamily: "Montserrat",
      errorColor: appColors.red,
      primaryColor: appColors.green,
      focusColor: appColors.green,
      highlightColor: appColors.white,
      indicatorColor: appColors.blue,
      scaffoldBackgroundColor: appColors.white,
      snackBarTheme: SnackBarThemeData(),
      textTheme: TextTheme(),
    );
  }
}
