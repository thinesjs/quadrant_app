import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:quadrant_app/controllers/AuthController.dart';
import 'package:quadrant_app/pages/screens/Onboarding/OnboardScreen.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({Key? key}) : super(key: key);

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => SplashScreen());
  }

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: SvgPicture.asset(
              "assets/logos/logo.svg", 
              height: height/9,
              colorFilter: ColorFilter.mode(isDark ? Colors.white : Colors.black, BlendMode.srcIn)
            ),
          ),
        ],
      ),
    );
  }
}
