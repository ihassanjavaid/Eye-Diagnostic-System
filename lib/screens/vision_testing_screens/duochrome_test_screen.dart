import 'dart:async';

import 'package:eye_diagnostic_system/components/header_clipper_component.dart';
import 'package:eye_diagnostic_system/screens/vision_testing_screens/vision_testing_main.dart';
import 'package:eye_diagnostic_system/utilities/constants.dart';
import 'package:eye_diagnostic_system/widgets/alert_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DuochromeTestScreen extends StatefulWidget {
  static const String id = 'duochrome_test_screen';
  @override
  _DuochromeTestScreen createState() => _DuochromeTestScreen();
}

class _DuochromeTestScreen extends State<DuochromeTestScreen> {
  String hyperopiaGreen01 =
      'assets/images/vision_testing/duo-chrome tests/green01.png';
  String hyperopiaGreen02 =
      'assets/images/vision_testing/duo-chrome tests/green02.png';
  String hyperopiaYellow01 =
      'assets/images/vision_testing/duo-chrome tests/yellow01.png';
  String hyperopiaYellow02 =
      'assets/images/vision_testing/duo-chrome tests/yellow02.png';

  String myopiaRed01 =
      'assets/images/vision_testing/duo-chrome tests/red01.png';
  String myopiaRed02 =
      'assets/images/vision_testing/duo-chrome tests/red02.png';
  String myopiaOrange01 =
      'assets/images/vision_testing/duo-chrome tests/orange01.png';
  String myopiaOrange02 =
      'assets/images/vision_testing/duo-chrome tests/orange02.png';

  String myopiaImage = '';
  String hyperopiaImage = '';

  int hyperopiaPressed = 0;
  int myopiaPressed = 0;

  String imageProgressionHyper(int pressed) {
    if (pressed == 0) {
      hyperopiaImage = hyperopiaGreen01;
    } else if (pressed == 1) {
      hyperopiaImage = hyperopiaGreen02;
    } else if (pressed == 2) {
      hyperopiaImage = hyperopiaYellow01;
    } else {
      hyperopiaImage = hyperopiaYellow02;
    }

    return hyperopiaImage;
  }

  String imageProgressionMyopia(int pressed) {
    if (pressed == 0) {
      myopiaImage = myopiaRed01;
    } else if (pressed == 1) {
      myopiaImage = myopiaRed02;
    } else if (pressed == 2) {
      myopiaImage = myopiaOrange01;
    } else {
      myopiaImage = myopiaOrange02;
    }

    return myopiaImage;
  }

  Widget _buildTopBox(image) {
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: Container(
        height: MediaQuery.of(context).size.height / 2.75,
        width: MediaQuery.of(context).size.width / 1.15,
        child: FittedBox(
          child: Image(
            image: AssetImage(image),
          ),
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Widget _buildMiddlePanel() {
    return Padding(
      padding: const EdgeInsets.only(left:30.0, right: 20.0, bottom: 10),
      child: Container(
        color: kScaffoldBackgroundColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: (){
                Navigator.popAndPushNamed(context, VisionTestingMain.id);
              },
              child: Icon(
                Icons.home,
                size: 30,
                color: kDarkTealColor,
              ),
            ),
            GestureDetector(
              onTap: () {
                AlertWidget()
                    .generateInstructions(context: context,
                    title: 'Instructions',
                    description: 'Tap on the colour which appears clearer to you and on the forward arrow if both are equally clear.')
                    .show();
              },
              child: Icon(
                Icons.help_outline,
                size: 30,
                color: kDarkTealColor,
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 30,
              color: kDarkTealColor,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildBottomBox(image) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10),
      child: Container(
        height: MediaQuery.of(context).size.height / 2.75,
        width: MediaQuery.of(context).size.width / 1.15,
        child: FittedBox(
          child: Image(
            image: AssetImage(image),
          ),
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Column(
          children: [
            // Container(
            //   color: kTealColor,
            //   height: 50,
            // ),
            ClipPath(
              clipper: HeaderCustomClipper(),
              child: Column(children: [
                Container(
                  color: kTealColor,
                  padding: const EdgeInsets.only(
                      left: 15, right: 15, top: 50.0, bottom: 40.0),
                  alignment: Alignment.center,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        RichText(
                          text: TextSpan(children: [
                            TextSpan(
                              text: 'Duo-Chrome\t',
                              style: kDashboardTitleTextStyle.copyWith(
                                  color: kAmberColor),
                            ),
                            TextSpan(
                              text: 'Test',
                              style: kDashboardTitleTextStyle.copyWith(
                                  color: kAmberColor),
                            ),
                          ]),
                        ),
                      ]),
                ),
              ]),
            ),
            // ClipRRect(
            //   borderRadius: BorderRadius.only(
            //       bottomLeft: Radius.circular(50),
            //       bottomRight: Radius.circular(50)),
            //   child: Container(
            //     color: kTealColor,
            //     height: 140,
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: [
            //         Text(
            //           'Duo-Chrome Test',
            //           style: kOnBoardingTitleStyle.copyWith(fontSize: 30),
            //         )
            //       ],
            //     ),
            //   ),
            // ),
            ClipRRect(
              borderRadius: BorderRadius.circular(60),
              child: Container(
                child: Column(
                  children: [
                    GestureDetector(
                      child:
                          _buildTopBox(imageProgressionHyper(hyperopiaPressed)),
                      onTap: () {
                        hyperopiaPressed = hyperopiaPressed + 1;
                        setState(() {
                          print(hyperopiaImage);
                          hyperopiaImage =
                              imageProgressionHyper(hyperopiaPressed);
                          print(hyperopiaImage);
                        });
                      },
                    ),
                    GestureDetector(
                      child: _buildBottomBox(
                          imageProgressionMyopia(myopiaPressed)),
                      onTap: () {
                        myopiaPressed = myopiaPressed + 1;
                        setState(() {
                          myopiaImage = imageProgressionMyopia(myopiaPressed);
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(),
            ),
            GestureDetector(
              child: _buildMiddlePanel(),
              onTap: () {
                hyperopiaPressed += 1;
                myopiaPressed += 1;
                setState(() {
                  myopiaImage = imageProgressionMyopia(myopiaPressed);
                  hyperopiaImage = imageProgressionHyper(hyperopiaPressed);
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
