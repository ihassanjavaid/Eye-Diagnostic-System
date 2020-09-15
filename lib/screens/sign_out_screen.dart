import 'dart:async';
import 'package:eye_diagnostic_system/services/auth_service.dart';
import 'package:eye_diagnostic_system/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'on_boarding_screen.dart';

class SignOutScreen extends StatefulWidget {
  static const String id = 'sign_out_screen';

  @override
  _SignOutScreenState createState() => _SignOutScreenState();
}

class _SignOutScreenState extends State<SignOutScreen> {
  Timer _timer;
  double _circleWidth = 3.5;
  Auth _auth = Auth();

  Widget _buildAnimatedEyeBall() {
    return Container(
      height: 30.0,
      child: AnimatedContainer(
        padding: EdgeInsets.all(2.0),
        duration: Duration(milliseconds: 2000),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: kTealColor,
        ),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 2000),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.transparent,
            border: Border.all(
              color: kAmberColor,
              width: _circleWidth,
            ),
          ),
        ),
      ),
    );
  }

  _animateCircle() {
    setState(() {
      _circleWidth = _circleWidth == 3.5 ? 0.1 : 3.5;
    });
  }

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(milliseconds: 2000), (Timer ticker) {
      _animateCircle();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
       color: kScaffoldBackgroundColor,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 40.0),
              child: Container(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image(
                      image: AssetImage('assets/images/eye_noball.png'),
                      height: 100,
                      width: 100,
                    ),
                    _buildAnimatedEyeBall(),
                  ],
                ),
              ),
            ),
            Center(
              child: RichText(
                text: TextSpan(children: [
                  TextSpan(
                    text: 'Eye\t',
                    style:
                    kDashboardTitleTextStyle.copyWith(color: kTealColor),
                  ),
                  TextSpan(
                    text: 'See',
                    style:
                    kDashboardTitleTextStyle.copyWith(color: kTealColor),
                  ),
                ]),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 8,
            ),
            Column(
              children: [
                Hero(
                  tag: 'sign_out_icon',
                  child: Icon(
                    Icons.power_settings_new,
                    color: kTealColor,
                    size: 100.0,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Are you sure you want to ',
                      style: kDashboardButtonLabelStyle.copyWith(fontSize: 20.0),
                    ),
                    Text(
                      'Sign Out?',
                      style: kDashboardButtonLabelStyle.copyWith(fontSize: 20.0),
                    ),
                  ],
                ),
                SizedBox(
                  height: 60.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal:10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        child: Text(
                          'No',
                          style: kDashboardButtonLabelStyle.copyWith(fontSize: 30.0),
                        ),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                      GestureDetector(
                        onTap: () async {
                          final SharedPreferences pref =
                          await SharedPreferences.getInstance();
                          await pref.setString('email', null);
                          await pref.setString('displayName', null);
                          await pref.setString('uid', null);
                          _auth.signOut();
                          Navigator.pushNamed(context, OnBoardingScreen.id);
                        },
                        child: Text(
                          'Yes',
                          style: kDashboardButtonLabelStyle.copyWith(fontSize: 30.0, color: kAmberColor),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
