import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker_app/onboarding.dart';
import 'package:flutter_expense_tracker_app/splashscreen.dart';
import 'package:flutter_expense_tracker_app/views/screens/home_screen.dart';

import 'error.dart';

class RouteGenerator {
  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) => SplashScreen());
      case '/onboard':
        return MaterialPageRoute(builder: (context) => Onboarding());
      case '/homepage':
        return MaterialPageRoute(builder: (context) => HomeScreen());
      default:
        // If there is no such named route, return an error page.
        return MaterialPageRoute(builder: (context) => ErrorScreen());
    }
  }
}