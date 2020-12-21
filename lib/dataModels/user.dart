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
      "gender": gender == Gender.values.asMap()[gender.index],
      "weight": weight,
      "height": height,
      "occupation": occupation,
      "dailyActivity": DailyActivity.values.asMap()[dailyActivity.index],
      "city": city,
      "initialBmi": bmi,
      "idealWeight": idealWeight,
      "goal": Goal.values.asMap()[goal.index],
      "targetWeight": targetWeight ?? weight,
      "targetDuration": targetDuration ?? 0,
      "dailyCalorieRequirement": dailyCalorieRequirement,
      "bmiGoal": bmiGoal,
      "accountCreatedOn": DateTime.now().toString(),
    };
  }
}
