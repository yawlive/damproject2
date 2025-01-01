import 'package:damproject/OnboardingScreens.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import '../GetStartedPage.dart';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Navigate to the HomePage after 3 seconds
    Timer(Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => OnboardingScreens()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // backgroundColor: Colors.amber[50],
        backgroundColor: Colors.amber,

        body: Center(
        child: Container(
          height: 300,
          width: 300,
          child: Center(
            child: Image.asset('assets/images/traveleatlogo.png',

              fit: BoxFit.cover,
            ),

          ),

        ),
      )
    );
  }
}

