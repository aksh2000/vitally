import 'package:flutter/material.dart';
import 'package:vitally/businessLogic/businessLogic.dart';
import 'package:vitally/utilities/appConfig/appColors.dart';
import 'package:vitally/utilities/appConfig/responsive.dart';
import 'package:vitally/utilities/appConfig/textTheme.dart';

class AppConfig {
  // This class is used to access the objects of classes dealing with the overall configutation of the app
  // Do not make any changes in this class unless absolutely necessary as changes cna reflect on the whole app

  final BuildContext context;
  final AppColors appColors = AppColors();
  BusinessLogic businessLogic;
  Responsive responsive;
  AppTextTheme appTextTheme;
  AppConfig(this.context) {
    businessLogic = BusinessLogic(context);
    responsive = Responsive(context);
    appTextTheme = AppTextTheme(responsive, appColors);
  }

  // Update the App Version code upon deployment
  final String appVersion = "v 1.0.0 -a";
}
