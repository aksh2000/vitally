import 'package:vitally/utilities/enums.dart';

class User {
  String userId;
  String firstName;
  String lastName;
  int age;
  double weight;
  double height;
  String occupation;
  DailyActivity dailyActivity;
  Gender gender;
  String city;
  double targetWeight;
  double targetDuration;
  double weeklyGoal;
  double bmiGoal;
  double bmi;
  double idealWeight;
  double dailyCalorieRequirement;
  int dailyWaterRequirement;
  Goal goal;

  //string values of enums
  String genderString;
  String dailyActivityString;
  String goalString;

  Map<String, dynamic> get userDetailsForRegistration {
    return {
      "firstName": firstName,
      "lastName": lastName,
      "age": age,
      "gender": gender == Gender.male ? "male" : "female",
      "weight": weight,
      "height": height,
      "occupation": occupation,
      "dailyActivity": convertDailyActivityToString(dailyActivity),
      "city": city,
      "initialBmi": bmi,
      "idealWeight": idealWeight,
      "goal": convertGoalToString(goal),
      "targetWeight": targetWeight ?? weight,
      "targetDuration": targetDuration ?? 0,
      "dailyCalorieRequirement": dailyCalorieRequirement,
      "dailyWaterRequirement": 3000,
      "bmiGoal": bmiGoal,
      "accountCreatedOn": DateTime.now().toString(),
    };
  }

  // ignore: missing_return
  String convertGoalToString(Goal goal) {
    switch (goal) {
      case Goal.beHealthier:
        return "Be Healthier";
      case Goal.gainWeight:
        return "Gain Weight";
      case Goal.loseWeight:
        return "Lose Weight";
    }
  }

  // ignore: missing_return
  String convertDailyActivityToString(DailyActivity dailyActivity) {
    switch (dailyActivity) {
      case DailyActivity.lightlyActive:
        return "Lightly Active";
      case DailyActivity.moderatelyActive:
        return "Moderately Active";
      case DailyActivity.sedentary:
        return "Sedentary";
      case DailyActivity.veryActive:
        return "Very Active";
    }
  }
}
