import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:vitally/dataModels/backendResponse.dart';

class AuthenticationHandler {
  Future<Response> signInWithEmailAndPassword(
      String email, String password) async {
    // *
    // To sign in user with Email and Password
    // This function expects the email has already been verified to be in expected format
    // *
    try {
      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      // sign in user with email and password provided
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

      // return a success response along with user Id in data key
      return Response(
        success: true,
        error: "",
        data: {
          "message": "Sign in Successful",
          "userId": firebaseAuth.currentUser.uid
        },
      );
    } on FirebaseAuthException catch (e) {
      return Response(
        success: false,
        error: "$e",
        data: {"message": e.message},
      );
    } catch (e) {
      return Response(
        success: true,
        error: "$e",
        data: {"message": "Failed to Sign In"},
      );
    }
  }

  Future<Response> signUpWithEmailAndPassword(
      String email, String password) async {
    // *
    // To Create a new account using email and password
    // This function expects the email has already been verified to be in expected format
    // *
    try {
      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      // sign up user with email and password provided
      await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      // return a success response along with user Id in data key
      return Response(
        success: true,
        error: "",
        data: {
          "message": "Sign Up Successful",
          "userId": firebaseAuth.currentUser.uid
        },
      );
    } on FirebaseAuthException catch (e) {
      return Response(
        success: false,
        error: "$e",
        data: {"message": e.message},
      );
    } catch (e) {
      return Response(
        success: true,
        error: "$e",
        data: {"message": "Failed to Sign Up"},
      );
    }
  }

  Future<Response> authenticateWithGoogle() async {
    // *
    // To Sign in with Google
    // *
    try {
      // signin with google account registered on device
      final GoogleSignInAccount googleSignInAccount =
          await GoogleSignIn().signIn();

      // Hold the authentication tokens after successful Sign in
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken,
      );

      // Sign in to the app with the credentials
      final UserCredential userCredentials =
          await FirebaseAuth.instance.signInWithCredential(credential);
      final User user = userCredentials.user;

      // User cannot be anonymous
      assert(!user.isAnonymous);

      // Users id token shouldn't be null
      assert(await user.getIdToken() != null);

      final User currentUser = FirebaseAuth.instance.currentUser;

      assert(user.uid == currentUser.uid);

      // return a success response along with userId in data key
      return Response(
        success: true,
        error: "",
        data: {
          "message": "Google Authentication Successful",
          "userId": user.uid,
        },
      );
    } on FirebaseAuthException catch (e) {
      return Response(
        success: false,
        error: "$e",
        data: {"message": e.message},
      );
    } catch (e) {
      return Response(
        success: false,
        error: "$e",
        data: {"message": "Google Authentication Failed"},
      );
    }
  }

  Future<Response> sendMailToResetPassword(String email) async {
    // *
    // To sign a password reset link to the provided mail address
    // This function expects the email has already been verified to be in expected format
    // *
    try {
      // Send Reset Password Link to email provided
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

      // return a success response
      return Response(
        success: true,
        error: "",
        data: {"message": "Check Your email for Reset Link"},
      );
    } on FirebaseAuthException catch (e) {
      return Response(
        success: false,
        error: "$e",
        data: {"message": e.message},
      );
    } catch (e) {
      return Response(
        success: false,
        error: "$e",
        data: {"message": "Failed to mail password reset link"},
      );
    }
  }

  Future<Response> signOut() async {
    // *
    // To sign out the user
    // This function does not concern about removing stored user credentials from local storage
    // *

    try {
      // Logout User
      FirebaseAuth.instance.signOut();
      GoogleSignIn().signOut();

      // Return a success response
      return Response(
          success: true,
          error: "",
          data: {"message": "Signed out successfully"});
    } on FirebaseAuthException catch (e) {
      return Response(
        success: false,
        error: "$e",
        data: {"message": e.message},
      );
    } catch (e) {
      // Return a error response
      return Response(
          success: false, error: "$e", data: {"message": "Failed to Sign Out"});
    }
  }
}
