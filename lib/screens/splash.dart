import 'package:flutter/material.dart';
import 'package:netflix_clone/screens/login.dart';
import 'dart:async';

import 'package:netflix_clone/screens/onboarding.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 10000), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => OnboardingScreen(),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            color: Colors.black,
          ),
          child: Center(
            child: Image.asset(
              "assets/images/netflix_logo0.png",
              width: 80,
              height: 80,
            ),
          ),
        ),
      ),
    );
  }
}
