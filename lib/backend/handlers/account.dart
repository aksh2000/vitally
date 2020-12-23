import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vitally/dataModels/backendResponse.dart';
import 'package:vitally/dataModels/user.dart';

class AccountHandler {
  Future<Response> createAccount(User user) async {
    try {
      await FirebaseFirestore.instance
          .collection(user.userId)
          .doc("userData")
          .set(user.userDetailsForRegistration);
      return Response(
          success: true,
          error: "none",
          data: {"message": "Account Created Successfully"});
    } on FirebaseException catch (e) {
      return Response(
        success: false,
        error: "$e",
        data: {"message": e.message},
      );
    } catch (e) {
      return Response(
          success: false,
          error: "$e",
          data: {"message": "Failed to Create Account"});
    }
  }
}
