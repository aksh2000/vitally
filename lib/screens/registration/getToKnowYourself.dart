import 'package:flutter/material.dart';
import 'package:vitally/utilities/appConfig/appConfig.dart';

import '../../vitally.dart';

class GetToKnowYourself extends StatelessWidget {
  AppConfig appConfig;

  @override
  Widget build(BuildContext context) {
    appConfig = AppConfig(context);
    return Scaffold(
      body: Container(
        padding:
            EdgeInsets.symmetric(horizontal: appConfig.responsive.width(32)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            sizedBox(67),
            backButton,
            sizedBox(38),
            pageHeader,
            sizedBox(35),
            yourBmiSection,
            sizedBox(37),
            idealWeightForYouSection,
            sizedBox(85),
          ],
        ),
      ),
    );
  }

  Widget get idealWeightForYouSection {
    appConfig.businessLogic.usersIdealWeight();
    String usersHealthyWeightRange =
        appConfig.businessLogic.healthyWeightRange();
    return Container(
      padding: EdgeInsets.only(left: appConfig.responsive.width(21)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Your Ideal Weight", style: appConfig.appTextTheme.textStyle15),
          sizedBox(3),
          Text(
              "${appConfig.context.findAncestorWidgetOfExactType<Vitally>().user.idealWeight}" +
                  " kg",
              style: appConfig.appTextTheme.textStyle16),
          sizedBox(5),
          Text("Healthy Weight range: " + usersHealthyWeightRange,
              style: appConfig.appTextTheme.textStyle17)
        ],
      ),
    );
  }

  Widget get yourBmiSection {
    appConfig.businessLogic.usersBmi();
    return Container(
      padding: EdgeInsets.only(left: appConfig.responsive.width(21)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Your BMI is", style: appConfig.appTextTheme.textStyle15),
          sizedBox(3),
          Text(
              "${appConfig.context.findAncestorWidgetOfExactType<Vitally>().user.bmi}" +
                  " kg/m\u00b2",
              style: appConfig.appTextTheme.textStyle16),
          sizedBox(5),
          Text("Healthy BMI range: 18.5 - 24.9",
              style: appConfig.appTextTheme.textStyle17)
        ],
      ),
    );
  }

  Widget get pageHeader {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            Text("Get to know", style: appConfig.appTextTheme.textStyle13),
            Text("Yourself", style: appConfig.appTextTheme.textStyle14),
          ],
        ),
        sizedBox(0, 10),
        Image.asset("assets/images/registration/getToKnowYourSelf.png",
            height: appConfig.responsive.height(136),
            width: appConfig.responsive.width(150))
      ],
    );
  }

  Widget get backButton {
    return InkWell(
      onTap: () {
        Navigator.pop(appConfig.context);
      },
      child: Icon(
        Icons.arrow_back_ios_rounded,
        color: appConfig.appColors.black,
        size: appConfig.responsive.height(24),
      ),
    );
  }

  SizedBox sizedBox(double height, [double width = 0]) {
    return SizedBox(
        height: appConfig.responsive.height(height),
        width: appConfig.responsive.width(width ?? 0));
  }
}
