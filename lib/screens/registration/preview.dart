import 'package:flutter/material.dart';
import 'package:vitally/dataModels/user.dart';
import 'package:vitally/utilities/appConfig/appConfig.dart';
import 'package:vitally/utilities/enums.dart';
import 'package:vitally/vitally.dart';
import 'package:vitally/widgets/button_1.dart';
import 'package:vitally/widgets/yourCalorieGoalTile.dart';

// ignore: must_be_immutable
class GoalPreview extends StatelessWidget {
  AppConfig appConfig;
  @override
  Widget build(BuildContext context) {
    appConfig = AppConfig(context);
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(
          left: appConfig.responsive.width(32),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            sizedBox(67),
            backButton,
            sizedBox(6),
            pageHeader,
            sizedBox(44),
            stats,
            button
          ],
        ),
      ),
    );
  }

  Widget get stats {
    appConfig.businessLogic.updateUserDailyCalorieRequirement();
    User user = appConfig.context.findAncestorWidgetOfExactType<Vitally>().user;
    bool isGoalBeHealthier = user.goal == Goal.beHealthier;
    return Container(
      padding: EdgeInsets.only(left: appConfig.responsive.width(14)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          YourCalorieGoalTile(
            heading: "Daily Calories required",
            content:
                "${user.dailyCalorieRequirement.toStringAsFixed(2)}" + " kcal",
            appConfig: appConfig,
          ),
          sizedBox(21),
          YourCalorieGoalTile(
            heading: "Current Weight",
            content: user.weight.toString() + " Kg",
            appConfig: appConfig,
          ),
          isGoalBeHealthier ? SizedBox() : statsForWeightGainAndWeightLoss,
          sizedBox(30),
        ],
      ),
    );
  }

  Widget get button {
    return Button(
        color: appConfig.appColors.green,
        title: "Create Account",
        height: appConfig.responsive.height(60),
        onTap: () async {
          await appConfig.businessLogic.createAccount();
        },
        appConfig: appConfig);
  }

  Widget get statsForWeightGainAndWeightLoss {
    User user = appConfig.context.findAncestorWidgetOfExactType<Vitally>().user;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sizedBox(21),
        YourCalorieGoalTile(
          heading: "Goal Duration",
          content: user.targetDuration.toString() + " Weeks",
          appConfig: appConfig,
        ),
        sizedBox(21),
        YourCalorieGoalTile(
          heading: "Weekly goal",
          content: user.weeklyGoal.toString() + " Kg",
          appConfig: appConfig,
        ),
        sizedBox(21),
        YourCalorieGoalTile(
          heading: "BMI goal",
          content: user.bmiGoal.toString() + " kg/m\u00b2",
          appConfig: appConfig,
        ),
      ],
    );
  }

  Widget get pageHeader {
    return Container(
      // padding: EdgeInsets.only(left: appConfig.responsive.width(18)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Text("Your Calorie", style: appConfig.appTextTheme.textStyle18),
              Text("Goal", style: appConfig.appTextTheme.textStyle19)
            ],
          ),
          Image.asset(
            "assets/images/registration/yourCalorieGoal.png",
            height: appConfig.responsive.height(126),
            width: appConfig.responsive.width(158),
            fit: BoxFit.scaleDown,
          )
        ],
      ),
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
