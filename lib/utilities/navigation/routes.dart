import 'package:flutter/material.dart';

//TODO: Need to define all routes and make screens

class RouteGenerator {
  Route<dynamic> generateRoute(RouteSettings settings) {
    final List<Object> arguments = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) {
          return Container();
        });

      case '/onBoarding':
        return MaterialPageRoute(builder: (context) {
          return Container();
        });

      case '/login':
        return MaterialPageRoute(builder: (context) {
          return Container();
        });

      case '/dashboard':
        var user = arguments[0];
        return MaterialPageRoute(builder: (context) {
          return Container();
        });
    }
  }
}
