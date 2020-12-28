import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vitally/utilities/appConfig/appConfig.dart';
import 'package:vitally/utilities/enums.dart';
import 'package:vitally/widgets/button_1.dart';
import 'package:vitally/widgets/customTextField.dart';
import 'package:vitally/widgets/customTextField_3.dart';
import 'package:vitally/widgets/dailyActivityContainer.dart';

class HelpUsKnowYouBetter extends StatefulWidget {
  @override
  _HelpUsKnowYouBetterState createState() => _HelpUsKnowYouBetterState();
}

class _HelpUsKnowYouBetterState extends State<HelpUsKnowYouBetter> {
  final TextEditingController firstNameTextController = TextEditingController();
  final TextEditingController lastNameTextController = TextEditingController();
  final TextEditingController ageTextController = TextEditingController();
  final TextEditingController weightTextController = TextEditingController();
  final TextEditingController heightTextController = TextEditingController();
  final TextEditingController occupationTextController =
      TextEditingController();
  final TextEditingController cityTextController = TextEditingController();
  final TextEditingController dailyActivityTextController =
      TextEditingController();
  Gender gender = Gender.male;
  DailyActivity dailyActivity = DailyActivity.sedentary;

  AppConfig appConfig;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    firstNameTextController.dispose();
    lastNameTextController.dispose();
    ageTextController.dispose();
    weightTextController.dispose();
    heightTextController.dispose();
    occupationTextController.dispose();
    cityTextController.dispose();
    dailyActivityTextController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    appConfig = AppConfig(context);
    return Scaffold(
      appBar: appBar,
      body: Container(
        width: appConfig.responsive.widthBasedOnPercentage(100),
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.symmetric(
          horizontal: appConfig.responsive.width(33),
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              buildName,
              sizedBox(27),
              ageAndGender,
              sizedBox(27),
              weight,
              sizedBox(27),
              height,
              sizedBox(27),
              occupation,
              sizedBox(27),
              dailyActivityTextField,
              sizedBox(27),
              city,
              sizedBox(23),
              continueButton,
            ],
          ),
        ),
      ),
    );
  }

  Widget get continueButton {
    return Button(
      appConfig: appConfig,
      title: "CONTINUE",
      onTap: () {
        appConfig.businessLogic.helpUsKnowYouBetterUpdateUserData(
            firstName: firstNameTextController.text,
            lastName: lastNameTextController.text,
            age: ageTextController.text,
            height: heightTextController.text,
            weight: weightTextController.text,
            city: cityTextController.text,
            occupation: occupationTextController.text,
            gender: gender,
            dailyActivity: dailyActivity);
      },
      color: appConfig.appColors.green,
    );
  }

  // *
  // Text Boxes
  // *

  Widget get weight {
    return CustomTextField3(
      textEditingController: weightTextController,
      appConfig: appConfig,
      textInputType: TextInputType.number,
      title: "Weight",
      validator: (value) {
        try {
          if (double.parse(value) < 1) return "Enter Valid Weight";
        } catch (e) {
          return "Invalid Weight";
        }
      },
      hintText: "56",
      suffixUnits: "kg",
    );
  }

  Widget get height {
    return CustomTextField3(
      textEditingController: heightTextController,
      appConfig: appConfig,
      textInputType: TextInputType.number,
      title: "Height",
      validator: (value) {
        try {
          if (double.parse(value) < 1) return "Enter Valid Height";
        } catch (e) {
          return "Invalid Height";
        }
      },
      hintText: "173",
      suffixUnits: "cms",
    );
  }

  Widget get occupation {
    return CustomTextField1(
      textEditingController: occupationTextController,
      appConfig: appConfig,
      textInputType: TextInputType.text,
      title: "Occupation",
      hintText: "Student",
    );
  }

  Widget get city {
    return CustomTextField1(
      textEditingController: cityTextController,
      appConfig: appConfig,
      textInputType: TextInputType.text,
      title: "City",
      hintText: "Mumbai",
    );
  }

  Widget get buildName {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        firstName,
        lastName,
      ],
    );
  }

  Widget get ageAndGender {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        age,
        genderSelection,
      ],
    );
  }

  Widget get firstName {
    return Container(
      width: appConfig.responsive.height(140),
      child: CustomTextField1(
        textEditingController: firstNameTextController,
        appConfig: appConfig,
        textInputType: TextInputType.name,
        title: "First Name",
        validator: (value) {
          return value.length > 10 ? "Maximum 10 characters" : null;
        },
        hintText: "Stevenson",
      ),
    );
  }

  Widget get dailyActivityTextField {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => showDailyActivityDialog,
        );
      },
      child: CustomTextField1(
        textEditingController: dailyActivityTextController,
        appConfig: appConfig,
        textInputType: TextInputType.text,
        title: "Daily Activity",
        enabled: false,
        hintText: "Select a Daily Activity",
      ),
    );
  }

  Widget get age {
    return Container(
      width: appConfig.responsive.height(100),
      child: CustomTextField1(
        textEditingController: ageTextController,
        appConfig: appConfig,
        textInputType: TextInputType.number,
        title: "Age",
        validator: (value) {
          try {
            return int.parse(value) < 1 ? "Invalid age" : null;
          } catch (e) {
            return "Invalid Value";
          }
        },
        hintText: "25",
      ),
    );
  }

  Widget get genderSelection {
    final genderChildren = <int, Widget>{
      Gender.male.index: SizedBox(
        height: appConfig.responsive.height(42),
        child:
            Center(child: Text("Male", style: TextStyle(fontFamily: "Roboto"))),
      ),
      Gender.female.index: SizedBox(
        height: appConfig.responsive.height(42),
        child: Center(
            child: Text("Female", style: TextStyle(fontFamily: "Roboto"))),
      )
    };
    return Container(
      width: appConfig.responsive.width(177),
      child: CupertinoSlidingSegmentedControl(
        backgroundColor: Colors.grey[100],
        thumbColor: appConfig.appColors.green,
        groupValue: gender.index,
        children: genderChildren,
        onValueChanged: (index) {
          setState(() {
            if (index == Gender.male.index)
              gender = Gender.male;
            else
              gender = Gender.female;
          });
        },
      ),
    );
  }

  Widget get lastName {
    return Container(
      width: appConfig.responsive.height(140),
      child: CustomTextField1(
        textEditingController: lastNameTextController,
        appConfig: appConfig,
        textInputType: TextInputType.name,
        title: "Last Name",
        validator: (value) {
          return value.length > 10 ? "Maximum 10 characters" : null;
        },
        hintText: "Smith",
      ),
    );
  }

  AppBar get appBar {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0.0,
      title: Text("Help us know you better",
          style: appConfig.appTextTheme.textStyle11),
      centerTitle: true,
      backgroundColor: appConfig.appColors.white,
    );
  }

  SizedBox sizedBox(double height, [double width = 0]) {
    return SizedBox(
        height: appConfig.responsive.height(height),
        width: appConfig.responsive.width(width ?? 0));
  }

  Widget get showDailyActivityDialog {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(22))),
      child: Container(
          height: appConfig.responsive.height(358),
          width: appConfig.responsive.width(300),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(22))),
          padding: EdgeInsets.symmetric(
            horizontal: appConfig.responsive.width(21),
            vertical: appConfig.responsive.height(35),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              DailyActivityContainer(
                appConfig: appConfig,
                title: "Sedentary",
                subTitle: "Little or no exercise",
                onTap: () {
                  dailyActivity = DailyActivity.sedentary;
                  dailyActivityTextController.text = "Sedentary";
                  Navigator.pop(context);
                },
              ),
              DailyActivityContainer(
                appConfig: appConfig,
                title: "Lightly Active",
                subTitle: "Exercises 1-3 days a week",
                onTap: () {
                  dailyActivity = DailyActivity.lightlyActive;
                  dailyActivityTextController.text = "Lightly Active";
                  Navigator.pop(context);
                },
              ),
              DailyActivityContainer(
                appConfig: appConfig,
                title: "Moderately Active",
                subTitle: "Exercises 3-5 days a week",
                onTap: () {
                  dailyActivity = DailyActivity.moderatelyActive;
                  dailyActivityTextController.text = "Moderately Active";
                  Navigator.pop(context);
                },
              ),
              DailyActivityContainer(
                appConfig: appConfig,
                title: "Very Active",
                subTitle: "Exercises 6-7 days a week",
                onTap: () {
                  dailyActivity = DailyActivity.veryActive;
                  dailyActivityTextController.text = "Very Active";
                  Navigator.pop(context);
                },
              )
            ],
          )),
    );
  }
}
