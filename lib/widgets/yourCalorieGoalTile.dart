import 'package:flutter/material.dart';
import 'package:vitally/utilities/appConfig/appConfig.dart';

class YourCalorieGoalTile extends StatelessWidget {
  final String heading;
  final String content;
  final AppConfig appConfig;

  YourCalorieGoalTile({this.heading, this.content, this.appConfig});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(heading, style: appConfig.appTextTheme.textStyle24),
        Text(content, style: appConfig.appTextTheme.textStyle25)
      ],
    );
  }
}
