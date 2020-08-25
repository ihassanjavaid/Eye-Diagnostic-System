import 'package:eye_diagnostic_system/screens/OnboardingScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(EyeSee());
}

class EyeSee extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Eye See',
      home: OnBoardingScreen(),
    );
  }
}
