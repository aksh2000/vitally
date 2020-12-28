import 'package:flutter/material.dart';
import 'package:vitally/utilities/appConfig/appConfig.dart';
import 'package:vitally/utilities/enums.dart';
import 'package:vitally/widgets/button_1.dart';
import 'package:vitally/widgets/goalTile.dart';

class GoalSelection extends StatefulWidget {
  @override
  _GoalSelectionState createState() => _GoalSelectionState();
}

class _GoalSelectionState extends State<GoalSelection> {
  AppConfig appConfig;
  Goal selectedGoal;
  @override
  Widget build(BuildContext context) {
    appConfig = AppConfig(context);
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: appConfig.responsive.width(32),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            sizedBox(67),
            backButton,
            sizedBox(6),
            pageHeader,
            sizedBox(77),
            goals,
            sizedBox(70),
            nextButton,
          ],
        ),
      ),
    );
  }

  Widget get goals {
    return Container(
        height: appConfig.responsive.height(260),
        padding:
            EdgeInsets.symmetric(horizontal: appConfig.responsive.width(22)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GoalTile(
              title: "Be Healthier",
              subTitle: "Eat and train to maintain your shape",
              isSelected: selectedGoal == Goal.beHealthier,
              onTap: () {
                setState(() {
                  selectedGoal = Goal.beHealthier;
                });
              },
              appConfig: appConfig,
            ),
            GoalTile(
              title: "Lose Weight",
              subTitle: "Get leaner and increase your stamina",
              isSelected: selectedGoal == Goal.loseWeight,
              onTap: () {
                setState(() {
                  selectedGoal = Goal.loseWeight;
                });
              },
              appConfig: appConfig,
            ),
            GoalTile(
              title: "Gain Weight",
              subTitle: "Build muscle and strengthen your body",
              isSelected: selectedGoal == Goal.gainWeight,
              onTap: () {
                setState(() {
                  selectedGoal = Goal.gainWeight;
                });
              },
              appConfig: appConfig,
            ),
          ],
        ));
  }

  Widget get nextButton {
    return Button(
        color:
            selectedGoal != null ? appConfig.appColors.green : Colors.grey[500],
        title: "Next",
        height: appConfig.responsive.height(60),
        onTap: () {
          appConfig.businessLogic
              .goalSelectionUpdateUserData(selectedGoal: selectedGoal);
        },
        appConfig: appConfig);
  }

  Widget get pageHeader {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            Text("What's your", style: appConfig.appTextTheme.textStyle18),
            Text("Goal?", style: appConfig.appTextTheme.textStyle19)
          ],
        ),
        SizedBox(
          width: appConfig.responsive.width(5),
        ),
        Image.asset(
          "assets/images/registration/whatsYourGoal.png",
          height: appConfig.responsive.height(118),
          width: appConfig.responsive.width(110),
        ),
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
