import 'dart:async';
import 'package:eye_diagnostic_system/screens/main_dashboard_screen.dart';
import 'package:eye_diagnostic_system/services/auth_service.dart';
import 'package:eye_diagnostic_system/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'community_screens/forum_screen.dart';
import 'login_screen.dart';

class Extras extends StatefulWidget {
  static const String id = 'extras_screen';

  @override
  _ExtrasState createState() => _ExtrasState();
}

class _ExtrasState extends State<Extras> {
  Timer _timer;
  double _circleWidth = 3.5;
  Auth _auth = Auth();

  Widget _buildAnimatedEyeBall() {
    return Container(
      height: 30.0,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 2000),
        padding: EdgeInsets.all(6),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: kPurpleColor.withOpacity(0.8),
        ),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 2000),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.transparent,
            border: Border.all(
              color: kGoldenColor,
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
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: kBgColorGradientArrayBlues,
            stops: [0.1, 0.4, 0.7, 0.9],
          ),
        ),
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
                        kDashboardTitleTextStyle.copyWith(color: kPurpleColor),
                  ),
                  TextSpan(
                    text: 'See',
                    style:
                        kDashboardTitleTextStyle.copyWith(color: kGoldenColor),
                  ),
                ]),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, Forum.id);
                      },
                      child: Hero(
                        tag: 'extras',
                        child: Icon(
                          Icons.person,
                          color: kGoldenColor,
                          size: 50.0,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      'My Profile',
                      style: kDashboardButtonLabelStyle,
                    ),
                  ],
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 4,
                ),
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, Forum.id);
                      },
                      child: Icon(
                        Icons.people,
                        color: kGoldenColor,
                        size: 50.0,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      'Community',
                      style: kDashboardButtonLabelStyle,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Icon(
                        Icons.alarm,
                        color: kGoldenColor,
                        size: 50.0,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      'Reminders',
                      style: kDashboardButtonLabelStyle,
                    ),
                  ],
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 4,
                ),
                Column(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        final SharedPreferences pref =
                            await SharedPreferences.getInstance();
                        await pref.setString('email', null);
                        await pref.setString('displayName', null);
                        _auth.signOut();
                        Navigator.pushNamed(context, LoginScreen.id);
                      },
                      child: Icon(
                        Icons.power_settings_new,
                        color: kGoldenColor,
                        size: 50.0,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      // extra white-spaces for indentation - don't remove
                      '  Sign Out  ',
                      style: kDashboardButtonLabelStyle,
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 52.0,
        color: kPurpleColor,
        child: Align(
          alignment: Alignment.centerLeft,
          child: GestureDetector(
            onTap: () {
              Navigator.popAndPushNamed(context, Dashboard.id);
            },
            child: Row(
              children: [
                SizedBox(
                  width: 20.0,
                ),
                Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                  size: 30.0,
                ),
                SizedBox(
                  width: 10.0,
                ),
                Text(
                  'Back',
                  style: kBottomNavBarTextStyle
                ),
              ],
            ),
          )
        ),
      ),
    );
  }
}
