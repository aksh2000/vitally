import 'package:flutter/material.dart';
import 'package:vitally/utilities/appConfig/appConfig.dart';

class DailyActivityContainer extends StatelessWidget {
  final AppConfig appConfig;
  final String title;
  final String subTitle;
  final Function onTap;

  DailyActivityContainer(
      {@required this.appConfig,
      @required this.title,
      @required this.subTitle,
      @required this.onTap});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: appConfig.responsive.height(63),
        width: appConfig.responsive.width(258),
        padding: EdgeInsets.only(left: appConfig.responsive.width(15)),
        // alignment: Alignment.center,
        decoration: BoxDecoration(
            color: appConfig.appColors.white,
            border: Border.all(color: appConfig.appColors.green, width: 1),
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title, style: appConfig.appTextTheme.textStyle31),
            Text(subTitle, style: appConfig.appTextTheme.textStyle32),
          ],
        ),
      ),
    );
  }
}
