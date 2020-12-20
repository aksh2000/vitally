import 'package:flutter/material.dart';
import 'package:vitally/utilities/appConfig/appConfig.dart';

class Button extends StatelessWidget {
  final Color color;
  final String title;
  final Function onTap;
  final AppConfig appConfig;
  final double height;

  Button(
      {this.color,
      this.onTap,
      this.height,
      @required this.title,
      @required this.appConfig});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: this.onTap ?? () {},
      child: Container(
        height: this.height ?? appConfig.responsive.height(60),
        width: appConfig.responsive.width(311),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color ?? appConfig.appColors.blue,
          borderRadius: BorderRadius.all(
              Radius.circular(appConfig.responsive.height(16))),
        ),
        child: Text(
          "$title",
          style: appConfig.appTextTheme.textStyle2,
        ),
      ),
    );
  }
}
