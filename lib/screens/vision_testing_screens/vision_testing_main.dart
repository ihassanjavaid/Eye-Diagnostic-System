import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:eye_diagnostic_system/utilities/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class VisionTestingMain extends StatefulWidget {
  static const String id = 'vision_testing_main';

  @override
  _VisionTestingMainState createState() => _VisionTestingMainState();
}

class _VisionTestingMainState extends State<VisionTestingMain> {
  Timer _timer;
  double _circleWidth = 3.5;

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
            // Animated Eye Ball
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
            // Page Title
            Center(
              child: RichText(
                text: TextSpan(children: [
                  TextSpan(
                    text: 'EyeSee\t',
                    style: kDashboardTitleTextStyle.copyWith(color: kTealColor),
                  ),
                  TextSpan(
                    text: 'Vision\tPilot',
                    style: kDashboardTitleTextStyle.copyWith(color: kTealColor),
                  ),
                ]),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 12,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 35.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: kLightAmberColor
                          ),
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {},
                                child: Icon(
                                  FontAwesomeIcons.lowVision,
                                  color: kTealColor,
                                  size: 50.0,
                                ),
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              Text(
                                'Visual Acuity',
                                style: kDashboardButtonLabelStyle,
                              ),
                              Text(
                                'Test',
                                style: kDashboardButtonLabelStyle,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 30.0),
                          width: 240,
                          child: AutoSizeText(
                            'This test helps in ABC-XYZ',
                            style: kDashboardButtonLabelStyle.copyWith(fontSize: 20),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width / 8,
                    ),
                    Row(
                      children: [
                        Column(
                          children: [
                            GestureDetector(
                              onTap: () {},
                              child: Icon(
                                FontAwesomeIcons.palette,
                                color: kTealColor,
                                size: 50.0,
                              ),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Text(
                              'Duo-Chrome',
                              style: kDashboardButtonLabelStyle,
                            ),
                            Text(
                              'Test',
                              style: kDashboardButtonLabelStyle,
                            ),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 30.0),
                          width: 240,
                          child: AutoSizeText(
                            'This test helps in ABC-XYZ',
                            style: kDashboardButtonLabelStyle.copyWith(fontSize: 20),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width / 8,
                    ),
                    Row(
                      children: [
                        Column(
                          children: [
                            GestureDetector(
                              onTap: () {},
                              child: Icon(
                                FontAwesomeIcons.glasses,
                                color: kTealColor,
                                size: 50.0,
                              ),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Text(
                              'Near Vision',
                              style: kDashboardButtonLabelStyle,
                            ),
                            Text(
                              'Test',
                              style: kDashboardButtonLabelStyle,
                            ),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 30.0),
                          width: 240,
                          child: AutoSizeText(
                            'This test helps in ABC-XYZ',
                            style: kDashboardButtonLabelStyle.copyWith(fontSize: 20),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 52.0,
        color: kScaffoldBackgroundColor,
      ),
    );
  }
}
