import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

class Onboarding extends StatelessWidget {
  const Onboarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Stack(
            children: [
              SvgPicture.asset(
                "assets/onboard background.svg",
                fit: BoxFit.cover,
              ),
              Positioned(
                top: 0, // Adjust the top value as needed
                left: 0, // Adjust the left value as needed
                right: 0, // Adjust the right value as needed
                child: Image.asset(
                  "assets/Man.png",
                  // width: 200,
                  // height: 200,
                ),
              ),

              Positioned(
                top: 110, // Adjust the top value as needed
                left: 30, // Adjust the left value as needed
                // right: 0, // Adjust the right value as needed
                child: Image.asset(
                  "assets/Coint.png",
                  // width: 200,
                  // height: 200,
                ),
              ),

              Positioned(
                top: 160, // Adjust the top value as needed
                // left: 0, // Adjust the left value as needed
                right: 30, // Adjust the right value as needed
                child: Image.asset(
                  "assets/Donut.png",
                  // width: 200,
                  // height: 200,
                ),
              ),
  
            ],
          ),

          Center(child: Text('Track Smarter',style: TextStyle(color: Color(0xff2788FF),fontWeight: FontWeight.w600,fontSize: 26),)),
          Center(child: Text('Save More',style: TextStyle(color: Color(0xff2788FF),fontWeight: FontWeight.w600,fontSize: 26))),
ElevatedButton(
  onPressed: () {
    Navigator.pushNamed(context, '/homepage');
  },
  style: ButtonStyle(
    fixedSize: MaterialStateProperty.all(
      Size.fromWidth(200),
    ),
    shape: MaterialStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
    backgroundColor: MaterialStateProperty.all(
      Color(0xff2788FF), // Set your desired background color
    ),
  ),
  child: Text('Get Started',style: TextStyle(color: Colors.white),),
)

        ],
      ),
    );
  }
}
