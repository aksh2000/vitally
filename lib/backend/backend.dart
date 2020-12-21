import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vitally/dataModels/backendResponse.dart';
import 'package:vitally/dataModels/user.dart';

class Backend {
  //This class is responsible for firestore data writing / updating

  Future<Response> createAccount(User user,
      [int count = 0, String error = ""]) async {
    if (count <= 5) {
      try {
        await FirebaseFirestore.instance
            .collection(user.userId)
            .doc("userData")
            .set(user.userDetailsForRegistration);
        return Response(
            success: true,
            error: "none",
            data: {"message": "Account Created Successfully"});
      } catch (e) {
        return await createAccount(user, count++, e.toString());
      }
    } else {
      return Response(
          success: false,
          error: error,
          data: {"message": "Failed to Create Account"});
    }
  }
}
