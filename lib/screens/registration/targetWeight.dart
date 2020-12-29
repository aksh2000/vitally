import 'package:flutter/material.dart';
import 'package:vitally/utilities/appConfig/appConfig.dart';
import 'package:vitally/vitally.dart';
import 'package:vitally/widgets/button_1.dart';
import 'package:vitally/widgets/customTextField_3.dart';

// ignore: must_be_immutable
class TargetWeight extends StatelessWidget {
  AppConfig appConfig;
  final TextEditingController targetWeight = TextEditingController();
  final TextEditingController targetDuration = TextEditingController();
  @override
  Widget build(BuildContext context) {
    appConfig = AppConfig(context);
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: appConfig.responsive.width(32),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              sizedBox(67),
              backButton,
              sizedBox(6),
              pageHeader,
              sizedBox(77),
              textFieldsBody,
              sizedBox(130),
              nextButton,
            ],
          ),
        ),
      ),
    );
  }

  Widget get textFieldsBody {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: appConfig.responsive.width(22)),
      child: Column(
        children: [
          setYourTargetWeightTextField,
          sizedBox(35),
          setYourTargetDurationTextField
        ],
      ),
    );
  }

  Widget get nextButton {
    bool valuesEntered = (targetWeight.text != "" && targetDuration.text != "");
    return Button(
        color: valuesEntered ? appConfig.appColors.green : Colors.grey[500],
        title: "Next",
        height: appConfig.responsive.height(60),
        onTap: () {
          if (valuesEntered) {
            appConfig.businessLogic.targetWeightUpdateUserData(
                targetWeight: targetWeight.text,
                targetDuration: targetDuration.text);
          }
        },
        appConfig: appConfig);
  }

  Widget get setYourTargetDurationTextField {
    return CustomTextField3(
      textEditingController: targetDuration,
      appConfig: appConfig,
      title: "Set Your Target Duration",
      textInputType: TextInputType.number,
      enabled: true,
      suffixUnits: "week",
      hintText: "8",
    );
  }

  Widget get setYourTargetWeightTextField {
    return CustomTextField3(
      textEditingController: targetWeight,
      appConfig: appConfig,
      title: "Set Your Target Weight",
      textInputType: TextInputType.number,
      enabled: true,
      suffixUnits: "kg",
      hintText:
          "${appConfig.context.findAncestorWidgetOfExactType<Vitally>().user.idealWeight.toInt()}",
    );
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
        sizedBox(0, 5),
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
