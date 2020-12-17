import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vitally/vitally.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

  final bool isAppLaunchingForTheFirstTime =
      sharedPreferences.getBool("isAppLaunchingForTheFirstTime") ?? true;

  if (isAppLaunchingForTheFirstTime) {
    sharedPreferences.setBool("isAppLaunchingForTheFirstTime", false);
  }

  runApp(
    Vitally(
        sharedPreferences: sharedPreferences,
        isAppLaunchingForTheFirstTime: isAppLaunchingForTheFirstTime),
  );
}
