import 'package:eye_diagnostic_system/screens/main_dashboard_screen.dart';
import 'package:eye_diagnostic_system/screens/on_boarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AutoLoginService extends StatelessWidget {
  static const String id = 'auto_login_service';

  void routeDecider(context) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final String user_email = pref.getString('email');

    if (user_email != null) {
      print('Logged in automatically');
      Navigator.pushReplacementNamed(context, Dashboard.id);
      return;
    } else {
      print('First time sign in');
      Navigator.pushReplacementNamed(context, OnBoardingScreen.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    routeDecider(context);
    return Container();
  }
}