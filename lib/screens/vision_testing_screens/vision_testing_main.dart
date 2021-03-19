import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:eye_diagnostic_system/screens/vision_testing_screens/astigmatism_instructions_screen.dart';
import 'package:eye_diagnostic_system/screens/vision_testing_screens/duochrome_instructions_screen.dart';
import 'package:eye_diagnostic_system/screens/vision_testing_screens/visual_acuity_instructions_screen.dart';
import 'package:eye_diagnostic_system/utilities/constants.dart';
import 'package:eye_diagnostic_system/widgets/alert_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

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
              child: Column(
                children: [
                  // RichText(
                  //   textAlign: TextAlign.center,
                  //   text: TextSpan(children: [
                  //     TextSpan(
                  //       text: 'EyeSee\t',
                  //       style: kDashboardTitleTextStyle.copyWith(color: kTealColor),
                  //     ),
                  //   ]),
                  // ),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(children: [
                      TextSpan(
                        text: 'E-Optometrist',
                        style: kDashboardTitleTextStyle.copyWith(color: kTealColor)
                      ),
                    ]),
                  )
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 18,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: (){
                        Navigator.popAndPushNamed(context, VisualAcuityInstructionsScreen.id);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: kTealColor.withOpacity(0.8)
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(

                                // decoration: BoxDecoration(
                                //   borderRadius: BorderRadius.all(Radius.circular(20)),
                                //   color: kLightAmberColor
                                // ),
                                child: Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {},
                                      child: Image(
                                          image: AssetImage('assets/images/vision_testing/main_icons/snellen-chart (1).png'),
                                          height: 80,
                                          width: 80,
                                      ),
                                    ),
                                    // SizedBox(
                                    //   height: 20.0,
                                    // ),
                                    // Text(
                                    //   'Visual Acuity',
                                    //   style: kDashboardButtonLabelStyle.copyWith(color: kDarkTealColor, fontSize: 15),
                                    // ),
                                    // Text(
                                    //   'Test',
                                    //   style: kDashboardButtonLabelStyle,
                                    // ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 5.0, bottom: 20, top: 20, right: 20),
                              width: 240,
                              child: Column(
                                children: [
                                  Text(
                                    'Visual Acuity Test',
                                    style: kDashboardButtonLabelStyle.copyWith(color: kAmberColor, fontSize: 24),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'This test checks your ability to discern objects and faces ',
                                    style: kDashboardSubtitleTextStyle.copyWith(color: kDarkTealColor, fontSize: 15),
                                    textAlign: TextAlign.center,
                                  )
                                ],
                              ),
                              // child: AutoSizeText(
                              //   'This test checks visionary health',
                              //   style: kDashboardButtonLabelStyle.copyWith(fontSize: 20),
                              // ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width / 15,
                    ),
                    // Row(
                    //   children: [
                    //     Column(
                    //       children: [
                    //         GestureDetector(
                    //           onTap: () {},
                    //           child: Image(
                    //             image: AssetImage('assets/images/vision_testing/main_icons/ophtalmology.png'),
                    //             color: kDarkTealColor,
                    //             height: 80,
                    //             width: 80,
                    //           )
                    //         ),
                    //         SizedBox(
                    //           height: 20.0,
                    //         ),
                    //         Text(
                    //           'Duo-Chrome',
                    //           style: kDashboardButtonLabelStyle,
                    //         ),
                    //         Text(
                    //           'Test',
                    //           style: kDashboardButtonLabelStyle,
                    //         ),
                    //       ],
                    //     ),
                    //     Container(
                    //       padding: EdgeInsets.only(left: 30.0),
                    //       width: 240,
                    //       child: AutoSizeText(
                    //         'This test helps in ABC-XYZ',
                    //         style: kDashboardButtonLabelStyle.copyWith(fontSize: 20),
                    //       ),
                    //     )
                    //   ],
                    // ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, DuoChromeInstructionsScreen.id);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: kTealColor.withOpacity(0.8)
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(

                                // decoration: BoxDecoration(
                                //   borderRadius: BorderRadius.all(Radius.circular(20)),
                                //   color: kLightAmberColor
                                // ),
                                child: Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pushNamed(context, DuoChromeInstructionsScreen.id);
                                      },
                                      child: Image(
                                        image: AssetImage('assets/images/vision_testing/main_icons/ophtalmology.png'),
                                        height: 80,
                                        width: 80,
                                      ),
                                    ),
                                    // SizedBox(
                                    //   height: 20.0,
                                    // ),
                                    // Text(
                                    //   'Visual Acuity',
                                    //   style: kDashboardButtonLabelStyle.copyWith(color: kDarkTealColor, fontSize: 15),
                                    // ),
                                    // Text(
                                    //   'Test',
                                    //   style: kDashboardButtonLabelStyle,
                                    // ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 5.0, bottom: 20, top: 20, right: 20),
                              width: 240,
                              child: Column(
                                children: [
                                  Text(
                                    'Duo-Chrome Test',
                                    style: kDashboardButtonLabelStyle.copyWith(color: kAmberColor, fontSize: 24),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'This test diagnoses Myopia or Hyperopia in patients',
                                    style: kDashboardSubtitleTextStyle.copyWith(color: kDarkTealColor, fontSize: 15),
                                    textAlign: TextAlign.center,
                                  )
                                ],
                              ),
                              // child: AutoSizeText(
                              //   'This test checks visionary health',
                              //   style: kDashboardButtonLabelStyle.copyWith(fontSize: 20),
                              // ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width / 15,
                    ),
                    // Row(
                    //   children: [
                    //     Column(
                    //       children: [
                    //         GestureDetector(
                    //           onTap: () {},
                    //           child: Image(
                    //             image: AssetImage('assets/images/vision_testing/main_icons/eyeglasses.png'),
                    //             height: 80,
                    //             width: 80,
                    //           )
                    //         ),
                    //         SizedBox(
                    //           height: 20.0,
                    //         ),
                    //         Text(
                    //           'Near Vision',
                    //           style: kDashboardButtonLabelStyle,
                    //         ),
                    //         Text(
                    //           'Test',
                    //           style: kDashboardButtonLabelStyle,
                    //         ),
                    //       ],
                    //     ),
                    //     Container(
                    //       padding: EdgeInsets.only(left: 30.0),
                    //       width: 240,
                    //       child: AutoSizeText(
                    //         'This test helps in ABC-XYZ',
                    //         style: kDashboardButtonLabelStyle.copyWith(fontSize: 20),
                    //       ),
                    //     )
                    //   ],
                    // ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: kTealColor.withOpacity(0.8)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(

                              // decoration: BoxDecoration(
                              //   borderRadius: BorderRadius.all(Radius.circular(20)),
                              //   color: kLightAmberColor
                              // ),
                              child: Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {},
                                    child: Image(
                                      image: AssetImage('assets/images/vision_testing/main_icons/eyeglasses.png'),
                                      height: 80,
                                      width: 80,
                                    ),
                                  ),
                                  // SizedBox(
                                  //   height: 20.0,
                                  // ),
                                  // Text(
                                  //   'Visual Acuity',
                                  //   style: kDashboardButtonLabelStyle.copyWith(color: kDarkTealColor, fontSize: 15),
                                  // ),
                                  // Text(
                                  //   'Test',
                                  //   style: kDashboardButtonLabelStyle,
                                  // ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 5.0, bottom: 20, top: 20, right: 20),
                            width: 240,
                            child: Column(
                              children: [
                                Text(
                                  'Myopia Sight Test',
                                  style: kDashboardButtonLabelStyle.copyWith(color: kAmberColor, fontSize: 24),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'This test calculates your near-sightedness ocular health',
                                  style: kDashboardSubtitleTextStyle.copyWith(color: kDarkTealColor, fontSize: 15),
                                  textAlign: TextAlign.center,
                                )
                              ],
                            ),
                            // child: AutoSizeText(
                            //   'This test checks visionary health',
                            //   style: kDashboardButtonLabelStyle.copyWith(fontSize: 20),
                            // ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width / 15,
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.pushNamed(context, AstigmatismInstructionsScreen.id);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: kTealColor.withOpacity(0.8)
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(

                                // decoration: BoxDecoration(
                                //   borderRadius: BorderRadius.all(Radius.circular(20)),
                                //   color: kLightAmberColor
                                // ),
                                child: Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {},
                                      child: Image(
                                        image: AssetImage('assets/images/vision_testing/main_icons/eye-scanner.png'),
                                        height: 80,
                                        width: 80,
                                      ),
                                    ),
                                    // SizedBox(
                                    //   height: 20.0,
                                    // ),
                                    // Text(
                                    //   'Visual Acuity',
                                    //   style: kDashboardButtonLabelStyle.copyWith(color: kDarkTealColor, fontSize: 15),
                                    // ),
                                    // Text(
                                    //   'Test',
                                    //   style: kDashboardButtonLabelStyle,
                                    // ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 5.0, bottom: 20, top: 20, right: 20),
                              width: 240,
                              child: Column(
                                children: [
                                  Text(
                                    'Astigmatism Test',
                                    style: kDashboardButtonLabelStyle.copyWith(color: kAmberColor, fontSize: 24),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'This test checks your pupil\'s reaction to light refraction',
                                    style: kDashboardSubtitleTextStyle.copyWith(color: kDarkTealColor, fontSize: 15),
                                    textAlign: TextAlign.center,
                                  )
                                ],
                              ),
                              // child: AutoSizeText(
                              //   'This test checks visionary health',
                              //   style: kDashboardButtonLabelStyle.copyWith(fontSize: 20),
                              // ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 34.0,
        color: kScaffoldBackgroundColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom:20.0, right: 8.0, top: 4.0),
              child: GestureDetector(
                onTap: (){
                  AlertWidget().generateDisclaimer(context: context).show();
                  return;
                },
                child: Icon(
                  Icons.info_rounded,
                  color: kAmberColor.withOpacity(0.8),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
