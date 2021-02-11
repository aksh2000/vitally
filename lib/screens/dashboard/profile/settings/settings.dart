import 'package:flutter/material.dart';
import 'package:vitally/dataModels/user.dart';
import 'package:vitally/utilities/appConfig/appConfig.dart';
import 'package:vitally/vitally.dart';

// ignore: must_be_immutable
class SettingsScreen extends StatelessWidget {
  AppConfig appConfig;
  User user;
  @override
  Widget build(BuildContext context) {
    appConfig = AppConfig(context);
    user = appConfig.context.findAncestorWidgetOfExactType<Vitally>().user;
    return Scaffold(
      backgroundColor: appConfig.appColors.green,
      body: Padding(
        padding: EdgeInsets.only(top: appConfig.responsive.height(51)),
        child: Container(
          width: appConfig.responsive.widthBasedOnPercentage(100),
          height: appConfig.responsive.height(761),
          padding: EdgeInsets.symmetric(
            horizontal: appConfig.responsive.width(22),
          ),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: appConfig.appColors.lightGrey,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(appConfig.responsive.width(35)),
              topRight: Radius.circular(
                appConfig.responsive.width(35),
              ),
            ),
          ),
          child: body,
        ),
      ),
    );
  }

  Widget get body {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sizedBox(35),
        Text("Settings",
            style: appConfig.appTextTheme.textStyle29
                .copyWith(fontSize: appConfig.responsive.height(26))),
        sizedBox(15),
        settingsBanner1,
        sizedBox(20),
        settingsBanner2,
        sizedBox(20),
        settingsBanner3,
        sizedBox(20),
        settingsBanner4,
        sizedBox(20),
        settingsBanner5
      ],
    );
  }

  Widget get settingsBanner1 {
    return Container(
      height: appConfig.responsive.height(136),
      width: appConfig.responsive.width(311),
      decoration: BoxDecoration(
          color: appConfig.appColors.white,
          borderRadius: BorderRadius.all(Radius.circular(13))),
    );
  }

  Widget get settingsBanner2 {
    return Container(
      height: appConfig.responsive.height(56),
      width: appConfig.responsive.width(311),
      decoration: BoxDecoration(
          color: appConfig.appColors.white,
          borderRadius: BorderRadius.all(Radius.circular(13))),
    );
  }

  Widget get settingsBanner3 {
    return Container(
      height: appConfig.responsive.height(136),
      width: appConfig.responsive.width(311),
      decoration: BoxDecoration(
          color: appConfig.appColors.white,
          borderRadius: BorderRadius.all(Radius.circular(13))),
    );
  }

  Widget get settingsBanner4 {
    return Container(
      height: appConfig.responsive.height(166),
      width: appConfig.responsive.width(311),
      decoration: BoxDecoration(
          color: appConfig.appColors.white,
          borderRadius: BorderRadius.all(Radius.circular(13))),
    );
  }

  Widget get settingsBanner5 {
    //TODO: submit feedback option

    return Container(
      height: appConfig.responsive.height(56),
      width: appConfig.responsive.width(311),
      decoration: BoxDecoration(
          color: appConfig.appColors.white,
          borderRadius: BorderRadius.all(Radius.circular(13))),
    );
  }

  Widget seperatorHorizontal([double height = 0.5, double width = 297]) {
    return Container(
      color: appConfig.appColors.black.withOpacity(0.5),
      height: appConfig.responsive.height(height),
      width: appConfig.responsive.width(width),
    );
  }

  SizedBox sizedBox(double height, [double width = 0]) {
    return SizedBox(
        height: appConfig.responsive.height(height),
        width: appConfig.responsive.width(width ?? 0));
  }
}
