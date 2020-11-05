import 'package:eye_diagnostic_system/screens/main_dashboard_screen.dart';
import 'package:eye_diagnostic_system/services/auto_login_service.dart';
import 'package:eye_diagnostic_system/utilities/constants.dart';
import 'package:flare_splash_screen/flare_splash_screen.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  static const String id = 'splash_screen';

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen.navigate(
      name: 'assets/animations/eyeseesplash.flr',
      next: (_) => AutoLoginService(),
      isLoading: true,
      startAnimation: 'Intro',
      backgroundColor: kLightTealColor,
    );
  }
}
