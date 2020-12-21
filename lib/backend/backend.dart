import 'package:vitally/backend/handlers/account.dart';

class Backend {
  //  This class is responsible for firestore data writing / updating
  //  Every method of the following classes are expected to return a Response object
  final AccountHandler accountHandler = AccountHandler();
}
