import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vitally/backend/backend.dart';
import 'package:vitally/dataModels/backendResponse.dart';
import 'package:vitally/dataModels/user.dart';
import 'package:vitally/utilities/appConfig/appColors.dart';
import 'package:vitally/utilities/appConfig/responsive.dart';
import 'package:vitally/utilities/enums.dart';
import 'package:vitally/utilities/resources/idealWeight.dart' as resources;
import 'package:vitally/utilities/resources/idealWeightRange.dart';
import 'package:vitally/vitally.dart';
import 'dart:math' as math;

class BusinessLogic {
  final BuildContext context;
  final Backend backend = Backend();

  // Colors for snackbars
  final Color errorRed = AppColors().pastelRed;
  final Color errorText = AppColors().red;
  final Color successText = AppColors().thickGreen;
  final Color successGreen = AppColors().pastelGreen;

  BusinessLogic(this.context);

  Future<void> authenticateWithGoogle({bool isCalledFromSignUpPage}) async {
    Response backendResponse =
        await backend.authenticationHandler.authenticateWithGoogle();
    if (backendResponse.success) {
      // Save the required credentials in local Storage
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setString("user", backendResponse.data['userId']);
      sharedPreferences.setBool("userExists", true);

      // updating the User Data model in the Super Parent Widget
      context.findAncestorWidgetOfExactType<Vitally>().user.userId =
          backendResponse.data['userId'];

      // Send user to next Screen
      if (isCalledFromSignUpPage ?? true) {
        // registration process
        Navigator.pushReplacementNamed(context, '/helpUsKnowYouBetter');
      } else {
        // check if user details are available to proceed further
        await redirectAfterCheckingUserDetails();
      }
    } else {
      showSnackbar(
          backgroundColor: errorRed,
          textColor: errorText,
          content: backendResponse.data['message']);
    }
  }

  Future<void> signUp({String email, String password}) async {
    Response backendResponse = await backend.authenticationHandler
        .signUpWithEmailAndPassword(email, password);

    if (backendResponse.success) {
      // Save the required credentials in local Storage
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setString("user", backendResponse.data['userId']);
      sharedPreferences.setBool("userExists", true);

      // updating the User Data model in the Super Parent Widget
      context.findAncestorWidgetOfExactType<Vitally>().user.userId =
          backendResponse.data['userId'];

      // Send user to next Screen
      Navigator.pushReplacementNamed(context, '/helpUsKnowYouBetter');
    } else {
      showSnackbar(
          backgroundColor: errorRed,
          textColor: errorText,
          content: backendResponse.data['message']);
    }
  }

  Future<void> signIn({String email, String password}) async {
    Response backendResponse = await backend.authenticationHandler
        .signInWithEmailAndPassword(email, password);

    if (backendResponse.success) {
      // Save the required credentials in local Storage
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setString("user", backendResponse.data['userId']);
      sharedPreferences.setBool("userExists", true);

      // updating the user Data model in the Super Parent Widget
      context.findAncestorWidgetOfExactType<Vitally>().user.userId =
          backendResponse.data['userId'];

      // check if user details are available to proceed further
      await redirectAfterCheckingUserDetails();
    } else {
      showSnackbar(
          backgroundColor: errorRed,
          textColor: errorText,
          content: backendResponse.data['message']);
    }
  }

  Future<void> forgotPassword({String email, String password}) async {
    Response backendResponse =
        await backend.authenticationHandler.sendMailToResetPassword(email);

    if (backendResponse.success) {
      showSnackbar(
          backgroundColor: successGreen,
          textColor: successText,
          content: backendResponse.data['message']);

      // back to login screen
      Future.delayed(Duration(milliseconds: 3000))
          .whenComplete(() => Navigator.pop(context));
    } else {
      showSnackbar(
          backgroundColor: errorRed,
          textColor: errorText,
          content: backendResponse.data['message']);
    }
  }

  Future<void> signOut() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Response backendResponse = await backend.authenticationHandler.signOut();

    if (backendResponse.success) {
      // Remove User credentials from local storage
      sharedPreferences.remove("user");
      sharedPreferences.remove("userExists");

      // updating the user Data model in the Super Parent Widget
      context.findAncestorWidgetOfExactType<Vitally>().user.userId = "";

      // Send user to signin Page
      Navigator.pushReplacementNamed(context, '/signin');
    } else {
      showSnackbar(
          backgroundColor: errorRed,
          textColor: errorText,
          content: backendResponse.data['message']);
    }
  }

  Future<void> createAccount() async {
    final dynamic user = context.findAncestorWidgetOfExactType<Vitally>().user;
    Response backendResponse = await backend.accountHandler.createAccount(user);

    if (backendResponse.success) {
      showSnackbar(
          backgroundColor: successGreen,
          textColor: successText,
          content: backendResponse.data['message']);

      // to dashboard
      Future.delayed(Duration(milliseconds: 3000)).whenComplete(
          () => Navigator.pushReplacementNamed(context, '/dashboard'));
    } else {
      print(backendResponse.data['error']);
      showSnackbar(
          backgroundColor: errorRed,
          textColor: errorText,
          content: backendResponse.data['message']);
    }
  }

  Future<void> redirectAfterCheckingUserDetails() async {
    final dynamic user = context.findAncestorWidgetOfExactType<Vitally>().user;

    // check if user details are available in Firebase Firestore
    Response backendResponse =
        await backend.accountHandler.checkIfAccountDetailsAvailable(user);

    if (backendResponse.success) {
      showSnackbar(
          backgroundColor: AppColors().black,
          content: backendResponse.data['message']);

      // artificial delay while showing message
      Future.delayed(Duration(milliseconds: 3000)).whenComplete(() {
        Navigator.pushReplacementNamed(
            context, '${backendResponse.data["redirectUserTo"]}');
      });
    } else {
      showSnackbar(
          backgroundColor: errorRed,
          textColor: errorText,
          content: backendResponse.data['message']);
    }
  }

  void showSnackbar(
      {@required String content,
      Duration duration,
      @required Color backgroundColor,
      Color textColor}) {
    Flushbar(
      messageText: Text(
        content,
        style: TextStyle(
            fontFamily: "Roboto", color: textColor ?? AppColors().white),
        textAlign: TextAlign.center,
      ),
      backgroundColor: backgroundColor ?? AppColors().black,
      duration: duration ?? Duration(milliseconds: 2000),
      flushbarPosition: FlushbarPosition.BOTTOM,
      maxWidth: Responsive(context).width(267),
      margin: EdgeInsets.only(bottom: 35),
      blockBackgroundInteraction: true,
      padding: EdgeInsets.all(11),
      borderRadius: 5.0,
    )..show(context);
  }

  void goalSelectionUpdateUserData({@required Goal selectedGoal}) {
    User user = context.findAncestorWidgetOfExactType<Vitally>().user;
    try {
      if (selectedGoal == null) throw 'Select a goal to continue';

      // * update users goal in the parent widget
      user.goal = selectedGoal;

      // * move to next page based on the selected goal
      if (selectedGoal == Goal.beHealthier) {
        // user dont want to lose or gain weight
        user.targetWeight = user.weight;
        user.targetDuration = 0;
        user.weeklyGoal = 0;
        user.bmiGoal = user.bmi;

        Navigator.pushNamed(context, '/planReview');
      } else {
        Navigator.pushNamed(context, '/targetWeight');
      }
    } catch (e) {
      showSnackbar(
        content: e.toString(),
        backgroundColor: errorRed,
        textColor: errorText,
      );
    }
  }

  void targetWeightUpdateUserData(
      {@required String targetWeight, @required String targetDuration}) {
    User user = context.findAncestorWidgetOfExactType<Vitally>().user;
    try {
      if (targetWeight == null || targetDuration == null)
        throw 'Enter required values to continue';

      // * update users goal in the parent widget
      user.targetWeight = double.parse(targetWeight);
      user.targetDuration = double.parse(targetDuration);

      user.weeklyGoal = num.parse(
          ((user.targetWeight - user.weight) / user.targetDuration)
              .toStringAsFixed(2));

      user.bmiGoal = calculateBMI(
          heightInCms: user.height, weightInKgs: user.targetWeight);

      // * move to next page based
      Navigator.pushNamed(context, '/planReview');
    } on FormatException catch (e) {
      print(e.message);
      showSnackbar(
        content: "Please enter valid values to continue",
        backgroundColor: errorRed,
        textColor: errorText,
      );
    } catch (e) {
      showSnackbar(
        content: e.toString(),
        backgroundColor: errorRed,
        textColor: errorText,
      );
    }
  }

  void updateUserDailyCalorieRequirement() {
    User user = context.findAncestorWidgetOfExactType<Vitally>().user;

    // calculate user bmr
    double bmr = calculateBMR(
        height: user.height,
        weight: user.weight,
        age: user.age,
        gender: user.gender);
    // based on bmr and daily Activity calculate daily calorie requirement
    double dailyCalorieRequirements =
        calculateDailyCalorieRequirements(user.dailyActivity, bmr);

    // update user object
    user.dailyCalorieRequirement = dailyCalorieRequirements;
  }

  double calculateDailyCalorieRequirements(
      DailyActivity dailyActivity, double bmr) {
    // Daily calorie needs based on activity level

    switch (dailyActivity) {
      case DailyActivity.sedentary:
        return bmr * 1.3;
        break;
      case DailyActivity.lightlyActive:
        return bmr * 1.55;
        break;
      case DailyActivity.moderatelyActive:
        return bmr * 1.8;
        break;
      case DailyActivity.veryActive:
        return bmr * 2;
        break;
    }

    return bmr;
  }

  double calculateBMR({double height, double weight, int age, Gender gender}) {
    // BMR: Basal metabolic rate
    // Using Revised Harris-Benedict Equation
    // BMR (for Men) = 13.397W + 4.799H - 5.677A + 88.362
    // BMR (for Women) = 9.247W + 3.098H - 4.330A + 447.593
    // W - weight in KG
    // H - height in cms
    // A - age in years
    double bmr;
    switch (gender) {
      case Gender.male:
        bmr = (13.397 * weight) + (4.799 * height) - (5.677 * age) + 88.362;
        break;
      case Gender.female:
        bmr = (9.247 * weight) + (3.098 * height) - (4.33 * age) + 447.593;
        break;
    }
    bmr = num.parse(bmr.toStringAsFixed(1));
    return bmr;
  }

  void helpUsKnowYouBetterUpdateUserData({
    String firstName,
    String lastName,
    String age,
    String height,
    String weight,
    String city,
    String occupation,
    Gender gender,
    DailyActivity dailyActivity,
  }) {
    try {
      // *
      // * The following block of code is for exception handling
      // * In the case when user does not enter a value in a particular text field
      // *

      String errorMessageToBeDisplayed = "";

      if (firstName.length == 0) errorMessageToBeDisplayed += "First Name, ";
      if (lastName.length == 0) errorMessageToBeDisplayed += "Last Name, ";
      if (age.length == 0) errorMessageToBeDisplayed += "Age, ";
      if (height.length == 0) errorMessageToBeDisplayed += "Height, ";
      if (weight.length == 0) errorMessageToBeDisplayed += "Weight, ";
      if (occupation.length == 0) errorMessageToBeDisplayed += "Occupation, ";
      if (city.length == 0) errorMessageToBeDisplayed += "City";

      if (errorMessageToBeDisplayed.length > 0)
        throw "Please provide your " + "$errorMessageToBeDisplayed";
      // *
      // * If all the required fields have valid and non-null values,
      // * Then proceed with updating user object and moving to next step of registration process
      // *

      // *
      // * Update the user object in parent widget
      // *
      context.findAncestorWidgetOfExactType<Vitally>().user
        ..firstName = firstName
        ..lastName = lastName
        ..age = int.parse(age)
        ..height = double.parse(height)
        ..weight = double.parse(weight)
        ..occupation = occupation
        ..city = city
        ..gender = gender
        ..dailyActivity = dailyActivity;

      // *
      // * Next step in Registration
      // *
      Navigator.pushNamed(context, "/getToKnowYourself");
      // *
    } on FormatException catch (e) {
      // *
      // * If the format errors were to arise for age,height and weight
      // *
      showSnackbar(
        content: e.message.toString(),
        backgroundColor: errorRed,
        textColor: errorText,
      );
    } catch (e) {
      showSnackbar(
        content: e.toString(),
        backgroundColor: errorRed,
        textColor: errorText,
      );
    }
  }

  void usersBmi() {
    double userHeight =
        context.findAncestorWidgetOfExactType<Vitally>().user.height;
    double userWeight =
        context.findAncestorWidgetOfExactType<Vitally>().user.weight;

    double userBMI =
        calculateBMI(heightInCms: userHeight, weightInKgs: userWeight);

    context.findAncestorWidgetOfExactType<Vitally>().user.bmi = userBMI;
  }

  double calculateBMI({double heightInCms, double weightInKgs}) {
    // * BMI = (Weight in KG ) / (Height in M)^2
    // * User will give his height in cms, so that should be converted to M before calculating BMI
    // * BMI = Body Mass Index

    double userHeightInMeters = heightInCms / 100;
    double userBMI;
    userBMI = weightInKgs / math.pow(userHeightInMeters, 2);
    userBMI = num.parse(userBMI.toStringAsFixed(1));

    return userBMI;
  }

  void usersIdealWeight() {
    // *
    // * determine ideal weight based on gender and height
    // *
    String genderKey =
        context.findAncestorWidgetOfExactType<Vitally>().user.gender ==
                Gender.male
            ? "male"
            : "female";
    double userHeight =
        context.findAncestorWidgetOfExactType<Vitally>().user.height;
    int idealWeightId;
    if (userHeight <= 152.4) {
      idealWeightId = 1;
    } else if (userHeight >= 203.2) {
      idealWeightId = 21;
    } else {
      idealWeightId = (((userHeight - 152.4) ~/ 2.54).abs() + 2.54).toInt();
    }

    context.findAncestorWidgetOfExactType<Vitally>().user.idealWeight =
        resources.idealWeight[idealWeightId][genderKey].toDouble();
  }

  String healthyWeightRange() {
    // determine healthy Weight range based on height
    double userHeight =
        context.findAncestorWidgetOfExactType<Vitally>().user.height;

    int heightId;
    if (userHeight <= 148) {
      heightId = 1;
    } else if (userHeight > 204) {
      heightId = 29;
    } else {
      heightId = ((userHeight - 148) ~/ 2).abs() + 2;
    }

    return idealWeightRange[heightId];
  }
}
