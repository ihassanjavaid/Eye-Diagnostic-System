import 'package:eye_diagnostic_system/components/header_clipper_component.dart';
import 'package:eye_diagnostic_system/screens/main_dashboard_screen.dart';
import 'package:eye_diagnostic_system/screens/on_boarding_screen.dart';
import 'package:eye_diagnostic_system/services/biometric_service.dart';
import 'package:eye_diagnostic_system/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AutoLoginService extends StatelessWidget {
  static const String id = 'auto_login_service';
  BiometricService _biometricService = BiometricService();

  void routeDecider(context) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final String user_email = pref.getString('email');

    if (user_email != null) {
      print('Returning User - Logged in automatically');
      bool forward = await checkBiometics();
      if (forward){
        Navigator.pushReplacementNamed(context, Dashboard.id);
      }
      else if (!forward) {
        Navigator.popUntil(context, (route) => route.isFirst);
        Navigator.pop(context);
      }
      return;
    } else {
      print('New User - First time sign in');
      Navigator.pushReplacementNamed(context, OnBoardingScreen.id);
    }
  }

  Future<bool> checkBiometics() async {
    bool flag = await _biometricService.isBiometricAuthEnabled();
    bool authenticated = false;

    // If biometric auth not enabled, simply redirect to main screen
    if (!flag){
      return true;
    }

    try {
      authenticated = await _biometricService.authenticateWithBiometrics();
    }
    catch (err) {
      return false;
    }
    return authenticated;
  }

  @override
  Widget build(BuildContext context) {
    routeDecider(context);
    return Scaffold(
      backgroundColor: kScaffoldBackgroundColor,
      body: Container(
        child: Column(
          children: [
            ClipPath(
              clipper: HeaderCustomClipper(),
              child: Container(
                width: double.infinity,
                height: 160,
                color: kTealColor,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 35.0, bottom: 10.0),
                      child: RichText(
                        text: TextSpan(children: [
                          TextSpan(
                            text: 'My\t',
                            style: kDashboardTitleTextStyle.copyWith(
                                color: kAmberColor),
                          ),
                          TextSpan(
                            text: 'EyeSee',
                            style: kDashboardTitleTextStyle.copyWith(
                                color: kAmberColor),
                          ),
                        ]),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Text(
                          "${DateFormat('EEEE').format(DateTime.now())}, ${DateFormat('jm').format(DateTime.now())}",
                          style: kDashboardTitleTextStyle.copyWith(
                              fontSize: 20.0)),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 28.0),
              child: CircularProgressIndicator(
                backgroundColor: kTealColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}