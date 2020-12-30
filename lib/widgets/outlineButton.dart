import 'package:flutter/material.dart';
import 'package:vitally/utilities/appConfig/appConfig.dart';

class OutlineButtonWithIcon extends StatelessWidget {
  final AppConfig appConfig;
  final Color color;
  final Function onTap;
  final IconData icon;
  final double height;
  final double width;
  final String title;

  OutlineButtonWithIcon(
      {@required this.appConfig,
      this.color,
      @required this.onTap,
      @required this.icon,
      @required this.title,
      this.height,
      this.width});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height ?? appConfig.responsive.height(26),
        width: width ?? appConfig.responsive.width(83),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            border:
                Border.all(color: color ?? appConfig.appColors.blue, width: 1),
            borderRadius: BorderRadius.all(Radius.circular(5))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.create,
              color: color ?? appConfig.appColors.blue,
              size: appConfig.responsive.height(15),
            ),
            SizedBox(width: appConfig.responsive.width(1.5)),
            Text("$title", style: appConfig.appTextTheme.textStyle28)
          ],
        ),
      ),
    );
  }
}
