import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vitally/utilities/appConfig/appColors.dart';
import 'package:vitally/utilities/appConfig/appTheme.dart';
import 'package:vitally/utilities/navigation/routes.dart';

import 'dataModels/user.dart';

// class Vitally extends StatefulWidget {

//   @override
//   _VitallyState createState() => _VitallyState();
// }

class Vitally extends StatelessWidget {
  final RouteGenerator routes = RouteGenerator();
  final User user = User();
  final AppTheme appTheme = AppTheme(appColors: AppColors());

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
      key: Key("VitallyApp"),
      debugShowCheckedModeBanner: false,
      theme: appTheme.themeData,
      title: "Vitally",
      color: appTheme.appColors.white,
      onGenerateRoute: routes.generateRoute,
      initialRoute: '/',
    );
  }
}
