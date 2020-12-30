import 'package:flutter/material.dart';
import 'package:vitally/dataModels/user.dart';
import 'package:vitally/utilities/appConfig/appConfig.dart';
import 'package:vitally/vitally.dart';
import 'package:vitally/widgets/goalBannerDetailsHolder.dart';
import 'package:vitally/widgets/outlineButton.dart';
import 'package:vitally/widgets/userDetailsHolder.dart';

// ignore: must_be_immutable
class ProfileScreen extends StatelessWidget {
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
          alignment: Alignment.topCenter,
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
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          userBasicInfoBanner,
          sizedBox(14),
          userDetailsBanner,
          sizedBox(6),
          userGoalBanner,
          sizedBox(6),
          streaks,
          sizedBox(6),
          weightGraph,
          sizedBox(20),
          logoutButton,
          sizedBox(10),
          appVersion,
          sizedBox(25),
        ],
      ),
    );
  }

  Widget get userBasicInfoBanner {
    return Padding(
      padding: EdgeInsets.only(top: appConfig.responsive.height(34)),
      child: Container(
        width: appConfig.responsive.screenSize.width,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(
                  "assets/icons/userDP.png",
                  height: appConfig.responsive.height(164),
                  width: appConfig.responsive.width(164),
                ),
                SizedBox(width: appConfig.responsive.width(10)),
                userInfo,
              ],
            ),
            settingsIcon
          ],
        ),
      ),
    );
  }

  Widget get userInfo {
    return Container(
        width: appConfig.responsive.width(133),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("${user.firstName}",
                style: appConfig.appTextTheme.textStyle29),
            Text("${user.lastName}", style: appConfig.appTextTheme.textStyle29),
            sizedBox(9),
            Text(
              "${user.occupation}",
              style: appConfig.appTextTheme.textStyle30,
            ),
            sizedBox(24),
            editButton
          ],
        ));
  }

  Widget get settingsIcon {
    return Container(
      height: appConfig.responsive.height(164),
      alignment: Alignment.topCenter,
      child: InkWell(
        onTap: () {
          appConfig.businessLogic.signOut();
        },
        child: Icon(
          Icons.settings,
          color: appConfig.appColors.black.withOpacity(0.5),
          size: appConfig.responsive.height(24),
        ),
      ),
    );
  }

  Widget get logoutButton {
    return InkWell(
      onTap: () {
        showDialog(context: appConfig.context, child: logoutDialog);
      },
      child: Text(
        "LOGOUT",
        style: appConfig.appTextTheme.textStyle28
            .copyWith(decoration: TextDecoration.underline),
      ),
    );
  }

  Widget get logoutDialog {
    return Dialog(
      child: Container(
        height: appConfig.responsive.heightBasedOnPercentage(17),
        width: appConfig.responsive.widthBasedOnPercentage(85),
        // alignment: Alignment.center,
        padding: EdgeInsets.symmetric(
            vertical: appConfig.responsive.height(25),
            horizontal: appConfig.responsive.width(30)),
        decoration: BoxDecoration(
            color: appConfig.appColors.white,
            borderRadius: BorderRadius.all(Radius.circular(30))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Are your sure?",
              style: TextStyle(
                  fontSize: appConfig.responsive.height(19),
                  fontWeight: FontWeight.w500),
            ),
            sizedBox(appConfig.responsive.heightBasedOnPercentage(1.5)),
          ],
        ),
      ),
    );
  }

  Widget get editButton {
    return OutlineButtonWithIcon(
      appConfig: appConfig,
      title: "EDIT",
      icon: Icons.create,
      onTap: () {},
    );
  }

  Widget get userDetailsBanner {
    return Container(
      height: appConfig.responsive.height(72),
      width: appConfig.responsive.width(331),
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(
          vertical: appConfig.responsive.height(10),
          horizontal: appConfig.responsive.width(11)),
      decoration: BoxDecoration(
          color: appConfig.appColors.white,
          borderRadius: BorderRadius.all(Radius.circular(13))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          UserDetailsHolder(
            title: "Age",
            value: user.age.toString(),
            units: "yrs",
            appConfig: appConfig,
          ),
          seperator,
          UserDetailsHolder(
            title: "Weight",
            value: user.weight.toString(),
            units: "kgs",
            appConfig: appConfig,
          ),
          seperator,
          UserDetailsHolder(
            title: "Height",
            value: user.height.toString(),
            units: "cms",
            appConfig: appConfig,
          ),
        ],
      ),
    );
  }

  Widget get seperator {
    return Container(
      color: appConfig.appColors.black.withOpacity(0.5),
      height: appConfig.responsive.height(27),
      width: 0.5,
    );
  }

  Widget get streaks {
    return Container(
      height: appConfig.responsive.height(127),
      width: appConfig.responsive.width(331),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: appConfig.appColors.white,
          borderRadius: BorderRadius.all(Radius.circular(13))),
      padding: EdgeInsets.symmetric(
          vertical: appConfig.responsive.height(10),
          horizontal: appConfig.responsive.width(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Text("Streaks", style: appConfig.appTextTheme.textStyle36),
          // seperatorHorizontal,
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     GoalBannerDetailsHolder(
          //       title: "Target weight",
          //       value: user.targetWeight.toString(),
          //       units: "kgs",
          //       appConfig: appConfig,
          //     ),
          //     GoalBannerDetailsHolder(
          //       title: "Target Duration",
          //       value: user.targetDuration.toInt().toString(),
          //       units: "weeks",
          //       appConfig: appConfig,
          //     ),
          //   ],
          // )
        ],
      ),
    );
  }

  Widget get appVersion {
    return Center(
      child: Text("${appConfig.appVersion}",
          style: TextStyle(
              fontSize: appConfig.responsive.height(11),
              fontFamily: "Roboto",
              color: appConfig.appColors.black.withOpacity(0.4))),
    );
  }

  Widget get weightGraph {
    return Container(
      height: appConfig.responsive.height(250),
      width: appConfig.responsive.width(331),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: appConfig.appColors.white,
          borderRadius: BorderRadius.all(Radius.circular(13))),
      padding: EdgeInsets.symmetric(
          vertical: appConfig.responsive.height(10),
          horizontal: appConfig.responsive.width(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [],
      ),
    );
  }

  Widget get userGoalBanner {
    return Container(
      height: appConfig.responsive.height(127),
      width: appConfig.responsive.width(331),
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(
          vertical: appConfig.responsive.height(10),
          horizontal: appConfig.responsive.width(20)),
      decoration: BoxDecoration(
          color: appConfig.appColors.white,
          borderRadius: BorderRadius.all(Radius.circular(13))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text("Goal", style: appConfig.appTextTheme.textStyle36),
          seperatorHorizontal,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GoalBannerDetailsHolder(
                title: "Target weight",
                value: user.targetWeight.toString(),
                units: "kgs",
                appConfig: appConfig,
              ),
              GoalBannerDetailsHolder(
                title: "Target Duration",
                value: user.targetDuration.toInt().toString(),
                units: "weeks",
                appConfig: appConfig,
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget get seperatorHorizontal {
    return Container(
      color: appConfig.appColors.black.withOpacity(0.5),
      height: appConfig.responsive.height(0.5),
      width: appConfig.responsive.width(297),
    );
  }

  SizedBox sizedBox(double height, [double width = 0]) {
    return SizedBox(
        height: appConfig.responsive.height(height),
        width: appConfig.responsive.width(width ?? 0));
  }
}
