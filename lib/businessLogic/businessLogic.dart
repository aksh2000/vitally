import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vitally/backend/backend.dart';
import 'package:vitally/dataModels/backendResponse.dart';
import 'package:vitally/utilities/appConfig/appColors.dart';

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

      // Send user to next Screen
      if (isCalledFromSignUpPage ?? true) {
        Navigator.pushReplacementNamed(
            context, '/dummy'); // registration process
      } else {
        Navigator.pushReplacementNamed(context, '/dummy'); // dashboard
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

      // Send user to next Screen
      Navigator.pushReplacementNamed(context, '/dummy');
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

      // Send user to next Screen
      Navigator.pushReplacementNamed(context, '/dummy');
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
}
