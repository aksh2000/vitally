import 'package:flutter/material.dart';
import 'package:vitally/utilities/appConfig/appConfig.dart';

class GoalTile extends StatelessWidget {
  final String title;
  final String subTitle;
  final bool isSelected;
  final Function onTap;
  final AppConfig appConfig;

  GoalTile(
      {@required this.title,
      @required this.subTitle,
      @required this.isSelected,
      @required this.onTap,
      @required this.appConfig});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: this.onTap,
      child: Container(
        height: appConfig.responsive.height(75),
        width: appConfig.responsive.width(267),
        padding: EdgeInsets.only(left: appConfig.responsive.width(15)),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
            color: isSelected
                ? appConfig.appColors.green
                : appConfig.appColors.white,
            border: Border.all(color: appConfig.appColors.green, width: 1),
            borderRadius: BorderRadius.all(Radius.circular(12))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: isSelected
                  ? appConfig.appTextTheme.textStyle21
                  : appConfig.appTextTheme.textStyle20,
            ),
            SizedBox(height: appConfig.responsive.height(3)),
            Text(
              subTitle,
              style: isSelected
                  ? appConfig.appTextTheme.textStyle23
                  : appConfig.appTextTheme.textStyle22,
            )
          ],
        ),
      ),
    );
  }
}
