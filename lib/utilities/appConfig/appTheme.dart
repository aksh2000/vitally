import 'package:flutter/material.dart';
import 'package:vitally/utilities/appConfig/appColors.dart';
import 'package:vitally/utilities/appConfig/responsive.dart';

class AppTheme {
  final AppColors appColors;
  final BuildContext context;
  ThemeData themeData;
  Responsive responsive;

  AppTheme({@required this.appColors, @required this.context}) {
    this.responsive = Responsive(context);
    this.themeData = ThemeData(
      fontFamily: "Montserrat",
      errorColor: appColors.red,
      primaryColor: appColors.green,
      focusColor: appColors.green,
      highlightColor: appColors.blue,
      indicatorColor: appColors.blue,
      primaryIconTheme: IconThemeData(
        color: appColors.blue,
        size: responsive.height(16),
      ),
      scaffoldBackgroundColor: appColors.white,
      snackBarTheme: SnackBarThemeData(),
      textTheme: TextTheme(),
    );
  }
}
