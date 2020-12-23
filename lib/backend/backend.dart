import 'package:vitally/backend/handlers/account.dart';
import 'package:vitally/backend/handlers/authentication.dart';

class Backend {
  //  This class is responsible for firestore data writing / updating
  //  Every method of the following classes are expected to return a Response object
  final AccountHandler accountHandler = AccountHandler();
  final AuthenticationHandler authenticationHandler = AuthenticationHandler();
}
