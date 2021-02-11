import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:firebase_core/firebase_core.dart';
import 'package:vitally/dataModels/backendResponse.dart';
import 'package:vitally/dataModels/user.dart';

class AccountHandler {
  Future<Response> createAccount(User user) async {
    try {
      await FirebaseFirestore.instance
          .collection("Users")
          .doc("${user.userId}")
          .set(user.userDetailsForRegistration);
      return Response(
          success: true,
          error: "",
          data: {"message": "Account Created Successfully"});
    } on FirebaseException catch (e) {
      return Response(
        success: false,
        error: "$e",
        data: {"message": e.message},
      );
    } catch (e) {
      print(e);
      return Response(
          success: false,
          error: "$e",
          data: {"message": "Failed to Create Account"});
    }
  }

  Future<Response> checkIfAccountDetailsAvailable(User user) async {
    try {
      // * check if a document exists in Users collection with userId as its name
      // * If it exists, that means the user has finished his registration
      // * return the user details and redirect user to dashboard
      // * In case it doesn't, return the user to registration flow
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('Users')
          .doc("${user.userId}")
          .get();

      if (documentSnapshot.exists) {
        return Response(
          success: true,
          error: "",
          data: {
            "message": "Hi ${user.firstName}, Welcome back!",
            "redirectUserTo": "/dashboard",
            "userDetails": documentSnapshot.data()
          },
        );
      } else {
        return Response(success: true, error: "User Details Not Found", data: {
          "message":
              "Please Finish Registration Process for ${FirebaseAuth.instance.currentUser.email}",
          "redirectUserTo": "/helpUsKnowYouBetter",
        });
      }
    } on FormatException catch (e) {
      return Response(
        success: false,
        error: "$e",
        data: {
          "message": e.message,
        },
      );
    } on FirebaseException catch (e) {
      return Response(
        success: false,
        error: "$e",
        data: {
          "message": e.message,
        },
      );
    } catch (e) {
      return Response(
        success: false,
        error: "$e",
        data: {
          "message": "$e",
        },
      );
    }
  }

  Future<Response> updateGoal(User user) async {
    try {
      await FirebaseFirestore.instance
          .collection("Users")
          .doc("${user.userId}")
          .update({
        // user class needs to have another map to update goal / plan
        // with Goal, duration, dailyCalories, goalBMI, goalWeight
      });

      return Response(
          success: true, error: "", data: {"message": "Updated Successfully"});
    } on FirebaseException catch (e) {
      return Response(
        success: false,
        error: "$e",
        data: {"message": e.message},
      );
    } catch (e) {
      return Response(
          success: false, error: "$e", data: {"message": "Failed to Update"});
    }
  }
}
