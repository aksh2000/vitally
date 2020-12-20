import 'package:flutter/material.dart';
import 'package:vitally/utilities/appConfig/appConfig.dart';

class OnboardingPage extends StatelessWidget {
  final String imageFilePath;
  final String title;
  final String description;
  final AppConfig appConfig;
  OnboardingPage({
    @required this.imageFilePath,
    @required this.title,
    @required this.description,
    @required this.appConfig,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: appConfig.responsive.height(398),
      width: appConfig.responsive.width(287),
      child: Column(
        children: [
          Image.asset(
            "$imageFilePath",
            height: appConfig.responsive.height(180),
            width: appConfig.responsive.width(266),
          ),
          sizedBox(61),
          Text(title,
              style: appConfig.appTextTheme.textTheme.headline1,
              textAlign: TextAlign.center),
          sizedBox(17),
          Text(
            description,
            style: appConfig.appTextTheme.textTheme.bodyText1,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  SizedBox sizedBox(double height, [double width = 0]) {
    return SizedBox(
        height: appConfig.responsive.height(height),
        width: appConfig.responsive.width(width ?? 0));
  }
}
