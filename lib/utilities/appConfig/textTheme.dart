import 'package:flutter/material.dart';
import 'package:vitally/utilities/appConfig/appColors.dart';
import 'package:vitally/utilities/appConfig/responsive.dart';

class AppTextTheme {
  final AppColors appColors;
  final Responsive responsive;
  TextTheme textTheme;

  AppTextTheme(this.responsive, this.appColors) {
    textTheme = TextTheme(
      headline1: TextStyle(
          color: appColors.white,
          fontSize: responsive.height(26),
          fontWeight: FontWeight.w700),
      bodyText1: TextStyle(
          color: appColors.white,
          fontSize: responsive.height(16),
          fontWeight: FontWeight.w400),
      button: TextStyle(
          color: appColors.white,
          fontSize: responsive.height(20),
          fontWeight: FontWeight.w600),
      bodyText2: TextStyle(
        color: appColors.white,
        fontSize: responsive.height(13),
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
