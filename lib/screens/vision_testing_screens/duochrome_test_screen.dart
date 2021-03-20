import 'dart:async';

import 'package:eye_diagnostic_system/components/header_clipper_component.dart';
import 'package:eye_diagnostic_system/models/provider_data.dart';
import 'package:eye_diagnostic_system/screens/vision_testing_screens/vision_testing_main.dart';
import 'package:eye_diagnostic_system/screens/vision_testing_screens/vision_result_screen.dart';
import 'package:eye_diagnostic_system/utilities/constants.dart';
import 'package:eye_diagnostic_system/widgets/alert_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:eye_diagnostic_system/models/vision_testing_models/duochrome_data.dart';
import 'package:provider/provider.dart';

class DuochromeTestScreen extends StatefulWidget {
  static const String id = 'duochrome_test_screen';
  final EyeType eyeType;

  const DuochromeTestScreen({Key key, this.eyeType}) : super(key: key);

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

  DuochromeData _data = DuochromeData(0,0,0,0);

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
    return Container(
      height: MediaQuery.of(context).size.height / 2.75,
      width: MediaQuery.of(context).size.width / 1.15,
      child: FittedBox(
        child: Image(
          image: AssetImage(image),
        ),
        fit: BoxFit.fill,
      ),
    );
  }

  Widget _buildBottomBar() {
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
    return Container(
      height: MediaQuery.of(context).size.height / 2.75,
      width: MediaQuery.of(context).size.width / 1.15,
      child: FittedBox(
        child: Image(
          image: AssetImage(image),
        ),
        fit: BoxFit.fill,
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
            ClipPath(
              clipper: HeaderCustomClipper(),
              child: Column(children: [
                Container(
                  color: kTealColor,
                  padding: const EdgeInsets.only(
                      left: 15, right: 15, top: 40.0, bottom: 45.0),
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
                                  color: kScaffoldBackgroundColor),
                            ),
                            TextSpan(
                              text: 'Test',
                              style: kDashboardTitleTextStyle.copyWith(
                                  color: kScaffoldBackgroundColor),
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
            Material(
              elevation: 16.0,
              borderRadius: BorderRadius.circular(12.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Container(
                  // decoration: BoxDecoration(
                  //   borderRadius: BorderRadius.circular(50)
                  // ),
                  child: Column(
                    children: [
                      GestureDetector(
                        child:
                            _buildTopBox(imageProgressionHyper(hyperopiaPressed)),
                        onTap: () {
                          if(widget.eyeType == EyeType.LEFT && hyperopiaImage==hyperopiaYellow02){
                            Navigator.pop(context);
                            Navigator.pop(context);
                            Navigator.pop(context);

                            Navigator.push(context, MaterialPageRoute(builder: (context) => VisionResultScreen(
                              testType: VisionTestType.DUO,
                            )));
                          }
                          else if(hyperopiaImage==hyperopiaYellow02){
                            AlertWidget().generateDuoEyeAlert(context: context, title: "Cover Right Eye", description: "Please repeat the test with your right eye covered").show();
                          }
                          if(widget.eyeType == EyeType.RIGHT){
                            Provider.of<ProviderData>(context, listen: false).updateRightHyperopia();
                            print(Provider.of<ProviderData>(context,listen:false).rightHyperopia);
                          }
                          else if(widget.eyeType == EyeType.LEFT){
                            Provider.of<ProviderData>(context, listen: false).updateLeftHyperopia();
                            print(Provider.of<ProviderData>(context,listen:false).leftHyperopia);
                          }
                          hyperopiaPressed = hyperopiaPressed + 1;
                          setState(() {
                            hyperopiaImage = imageProgressionHyper(hyperopiaPressed);
                          });
                        },
                      ),
                      GestureDetector(
                        child: _buildBottomBox(
                            imageProgressionMyopia(myopiaPressed)),
                        onTap: () {
                          if(widget.eyeType == EyeType.LEFT && myopiaImage==myopiaOrange02){
                            Navigator.pop(context);
                            Navigator.pop(context);
                            Navigator.pop(context);
                            Navigator.push(context, MaterialPageRoute(builder: (context) => VisionResultScreen(
                              testType: VisionTestType.DUO,
                            )));
                          }
                          else if(myopiaImage==myopiaOrange02){
                            AlertWidget().generateDuoEyeAlert(context: context, title: "Cover Right Eye", description: "Please repeat the test with your right eye covered").show();
                          }
                          if(widget.eyeType == EyeType.RIGHT){
                            Provider.of<ProviderData>(context, listen: false).updateRightMyopia();
                            print(Provider.of<ProviderData>(context,listen:false).rightMyopia);
                          }
                          else if(widget.eyeType == EyeType.LEFT){
                            Provider.of<ProviderData>(context, listen: false).updateLeftMyopia();
                            print(Provider.of<ProviderData>(context,listen:false).leftMyopia);
                          }
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
            ),
            Expanded(
              child: Container(),
            ),
            GestureDetector(
              child: _buildBottomBar(),
              onTap: () {
                if(widget.eyeType == EyeType.LEFT && hyperopiaPressed >=3 && hyperopiaPressed >= 3){
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => VisionResultScreen(
                    testType: VisionTestType.DUO,
                  )));
                }
                else if(widget.eyeType == EyeType.RIGHT && hyperopiaPressed >=3 && hyperopiaPressed >= 3){
                  AlertWidget().generateDuoEyeAlert(context: context, title: "Cover Right Eye", description: "Please repeat the test with your right eye covered").show();
                }
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
