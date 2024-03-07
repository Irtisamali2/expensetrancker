import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker_app/onboarding.dart';
import 'package:flutter_expense_tracker_app/views/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Simulate a delay of 2 seconds
    Future.delayed(
      Duration(seconds: 2),
      () {
        // Navigate to the main screen and replace the splash screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Onboarding()),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/Splash screen.png'),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}

