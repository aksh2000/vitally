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
  Goal goal;

  Map<String, dynamic> get userDetailsForRegistration {
    return {
      "firstName": firstName,
      "lastName": lastName,
      "age": age,
      "gender": Gender.values[gender.index].toString(),
      "weight": weight,
      "height": height,
      "occupation": occupation,
      "dailyActivity": DailyActivity.values[dailyActivity.index].toString(),
      "city": city,
      "initialBmi": bmi,
      "idealWeight": idealWeight,
      "goal": Goal.values[goal.index].toString(),
      "targetWeight": targetWeight ?? weight,
      "targetDuration": targetDuration ?? 0,
      "dailyCalorieRequirement": dailyCalorieRequirement,
      "dailyWaterRequirement": 3000,
      "bmiGoal": bmiGoal,
      "accountCreatedOn": DateTime.now().toString(),
    };
  }
}
