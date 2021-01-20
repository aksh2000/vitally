import 'package:flutter/material.dart';
import 'package:vitally/utilities/appConfig/appConfig.dart';

class OutlineButton extends StatelessWidget {
  final AppConfig appConfig;
  final Color color;
  final Function onTap;
  final double height;
  final double width;
  final String title;
  final Color borderColor;

  OutlineButton(
      {@required this.appConfig,
      this.color,
      this.borderColor,
      @required this.onTap,
      @required this.title,
      this.height,
      this.width});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: this.onTap ?? () {},
      child: Container(
        alignment: Alignment.center,
        height: this.height ?? appConfig.responsive.height(45),
        width: this.width ?? appConfig.responsive.width(113),
        decoration: BoxDecoration(
          color: this.color ?? appConfig.appColors.white,
          borderRadius: BorderRadius.all(
              Radius.circular(appConfig.responsive.height(16))),
          border: Border.all(
              color: this.borderColor ?? appConfig.appColors.blue,
              width: appConfig.responsive.width(2)),
        ),
        child: Text(
          "$title",
          style: appConfig.appTextTheme.textStyle2
              .copyWith(color: borderColor ?? appConfig.appColors.blue),
        ),
      ),
    );
  }
}
