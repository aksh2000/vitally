import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vitally/backend/backend.dart';
import 'package:vitally/dataModels/backendResponse.dart';
import 'package:vitally/utilities/appConfig/appColors.dart';
import 'package:vitally/utilities/enums.dart';
import 'package:vitally/utilities/resources/idealWeight.dart' as resources;
import 'package:vitally/utilities/resources/idealWeightRange.dart';
import 'package:vitally/vitally.dart';
import 'dart:math' as math;

class BusinessLogic {
  final BuildContext context;
  final Backend backend = Backend();

  BusinessLogic(this.context);

  Future<void> authenticateWithGoogle({bool isCalledFromSignUpPage}) async {
    Response backendResponse =
        await backend.authenticationHandler.authenticateWithGoogle();
    if (backendResponse.success) {
      // Save the required credentials in local Storage
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setString("user", backendResponse.data['userId']);

      // updating the User Data model in the Super Parent Widget
      context.findAncestorWidgetOfExactType<Vitally>().user.userId =
          backendResponse.data['userId'];

      // Send user to next Screen
      if (isCalledFromSignUpPage ?? true) {
        Navigator.pushReplacementNamed(
            context, '/helpUsKnowYouBetter'); // registration process
      } else {
        Navigator.pushReplacementNamed(context, '/dashboard'); // dashboard
      }
    } else {
      showFlushbar(
          color: AppColors().red, content: backendResponse.data['message']);
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

      // updating the User Data model in the Super Parent Widget
      context.findAncestorWidgetOfExactType<Vitally>().user.userId =
          backendResponse.data['userId'];

      // Send user to next Screen
      Navigator.pushReplacementNamed(context, '/helpUsKnowYouBetter');
    } else {
      showFlushbar(
          color: AppColors().red, content: backendResponse.data['message']);
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

      // updating the user Data model in the Super Parent Widget
      context.findAncestorWidgetOfExactType<Vitally>().user.userId =
          backendResponse.data['userId'];

      // Send user to next Screen
      Navigator.pushReplacementNamed(context, '/dashboard');
    } else {
      showFlushbar(
          color: AppColors().red, content: backendResponse.data['message']);
    }
  }

  Future<void> forgotPassword({String email, String password}) async {
    Response backendResponse =
        await backend.authenticationHandler.sendMailToResetPassword(email);

    if (backendResponse.success) {
      showFlushbar(
          color: Colors.green, content: backendResponse.data['message']);

      // back to login screen
      Future.delayed(Duration(milliseconds: 3000))
          .whenComplete(() => Navigator.pop(context));
    } else {
      showFlushbar(
          color: AppColors().red, content: backendResponse.data['message']);
    }
  }

  Future<void> signOut() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Response backendResponse = await backend.authenticationHandler.signOut();

    if (backendResponse.success) {
      // Remove User credentials from local storage
      sharedPreferences.remove("");

      // updating the user Data model in the Super Parent Widget
      context.findAncestorWidgetOfExactType<Vitally>().user.userId = "";

      // Send user to signin Page
      Navigator.pushReplacementNamed(context, '/signin');
    } else {
      showFlushbar(
          color: AppColors().red, content: backendResponse.data['message']);
    }
  }

  void showFlushbar(
      {@required String content, Duration duration, @required Color color}) {
    Flushbar(
      messageText: Text(content,
          style: TextStyle(fontFamily: "Roboto", color: AppColors().white)),
      backgroundColor: color ?? AppColors().black,
      duration: duration ?? Duration(milliseconds: 2000),
      blockBackgroundInteraction: true,
    )..show(context);
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

      if (firstName.length == 0) {
        errorMessageToBeDisplayed += "First Name, ";
      }
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
      showFlushbar(content: e.message.toString(), color: AppColors().red);
    } catch (e) {
      showFlushbar(content: e.toString(), color: AppColors().red);
    }
  }

  void usersBmi() {
    double userHeight =
        context.findAncestorWidgetOfExactType<Vitally>().user.height;
    double userWeight =
        context.findAncestorWidgetOfExactType<Vitally>().user.weight;

    // * BMI = (Weight in KG ) / (Height in M)^2
    // * User will give his height in cms, so that should be converted to M before calculating BMI
    // * BMI = Body Mass Index

    double userHeightInMeters = userHeight / 100;
    double userBMI;
    userBMI = userWeight / math.pow(userHeightInMeters, 2);
    userBMI = num.parse(userBMI.toStringAsFixed(1));

    context.findAncestorWidgetOfExactType<Vitally>().user.bmi = userBMI;
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
