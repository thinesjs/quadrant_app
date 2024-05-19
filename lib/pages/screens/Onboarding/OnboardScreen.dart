import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:quadrant_app/controllers/AuthController.dart';
import 'package:quadrant_app/pages/main_page.dart';
import 'package:quadrant_app/pages/screens/Authentication/Login/LoginScreen.dart';

class OnboardScreen extends StatefulWidget {
  const OnboardScreen({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const OnboardScreen());
  }

  @override
  State<OnboardScreen> createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}