import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vitally/dataModels/user.dart';

class Backend {
  //This class is responsible for firestore data writing / updating

  Future<bool> createAccount({User user}) async {
    try {
      await FirebaseFirestore.instance
          .collection(user.userId)
          .doc("userData")
          .set(user.userDetailsForRegistration);
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }
}
