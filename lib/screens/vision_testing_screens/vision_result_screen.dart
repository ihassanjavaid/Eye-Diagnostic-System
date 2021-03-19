import 'package:eye_diagnostic_system/components/header_clipper_component.dart';
import 'package:eye_diagnostic_system/models/provider_data.dart';
import 'package:eye_diagnostic_system/utilities/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:eye_diagnostic_system/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

class VisionResultScreen extends StatefulWidget {
  static const String id = 'vision_result_screen';

  final VisionTestType testType;

  const VisionResultScreen({Key key, this.testType}) : super(key: key);
  @override
  _VisionResultScreenState createState() => _VisionResultScreenState();
}


class _VisionResultScreenState extends State<VisionResultScreen> {
  String rightResult;
  String leftResult;

  void _createResults(BuildContext context){
    if(widget.testType == VisionTestType.DUO){
      _calculateDuoResults(context);
    }
    else if(widget.testType == VisionTestType.ASTIG){
      _calculateAstigResults(context);
    }
  }

  String _calculateAstigResults(BuildContext context){
    int right = Provider.of<ProviderData>(context,listen:false).right;
    int left = Provider.of<ProviderData>(context,listen:false).left;

    if(right>=2){
      rightResult = 'Astigmatism';
    }
    else if (right <2){
      rightResult = 'no Ocular Error';
    }

    if(left >= 2){
      leftResult = 'Astigmatism';
    }
    else if (left <2){
      leftResult = 'no Ocular Error';
    }
  }

  String _calculateDuoResults(BuildContext context){
    int rightMyopia = Provider.of<ProviderData>(context,listen:false).rightMyopia;
    int rightHyperopia = Provider.of<ProviderData>(context,listen:false).rightHyperopia;
    int leftMyopia = Provider.of<ProviderData>(context,listen:false).leftMyopia;
    int leftHyperopia = Provider.of<ProviderData>(context,listen:false).leftHyperopia;

    if(rightMyopia > rightHyperopia){
      rightResult = 'Myopia\nNear Sightedness';
    }
    else if(rightHyperopia > rightMyopia){
      rightResult = 'Hyperopia\nFar Sightedness';
    }
    else if(rightHyperopia == rightMyopia){
      rightResult = 'no Ocular Error';
    }


    if(leftMyopia > leftHyperopia){
      leftResult = 'Myopia\n Near Sightedness';
    }
    else if(leftHyperopia > leftMyopia){
      leftResult = 'Hyperopia\nFar Sightedness';
    }
    else if(leftHyperopia == leftMyopia){
      leftResult = 'no Ocular Error';
    }


  }

  @override
  Widget build(BuildContext context) {
    _createResults(context);
    return Scaffold(
        body: AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Column(children: [
        ClipPath(
          clipper: HeaderCustomClipper(),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
              color: kTealColor,
              padding: const EdgeInsets.only(
                  left: 15, right: 15, top: 50.0, bottom: 40.0),
              alignment: Alignment.center,
              child: Column(
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(children: [
                            TextSpan(
                              text: 'Duo-Chrome\t',
                              style: kDashboardTitleTextStyle.copyWith(
                                  color: kDarkTealColor),
                            ),
                            TextSpan(
                              text: 'Test\n',
                              style: kDashboardTitleTextStyle.copyWith(
                                  color: kDarkTealColor),
                            ),
                            TextSpan(
                              text: 'Results\n',
                              style: kDashboardTitleTextStyle.copyWith(
                                  color: kScaffoldBackgroundColor
                                      .withOpacity(0.8)),
                            )
                          ]),
                        ),
                      ]),
                  Container(
                    padding: EdgeInsets.only(bottom: 20),
                    child: Text(
                        "${DateFormat('EEEE').format(DateTime.now())}, ${DateFormat('jm').format(DateTime.now())}",
                        style: kDashboardTitleTextStyle.copyWith(
                            fontSize: 20.0, color: kAmberColor)),
                  ),
                ],
              ),
            ),
          ]),
        ),
        //Expanded(child: Container()),
        Container(
          padding: EdgeInsets.all(40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom:10.0),
                    child: Icon(
                      Icons.remove_red_eye,
                      size: 60,
                      color: kDarkTealColor,
                    ),
                  ),
                  RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(children: [
                        TextSpan(
                            text: 'Left\t',
                            style: kDashboardTitleTextStyle.copyWith(
                                color: kTealColor)),
                        TextSpan(
                          text: 'Eye',
                          style: kDashboardTitleTextStyle.copyWith(
                              color: kTealColor),
                        ),
                      ])),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Your left eye\n suffers from\n $leftResult',
                      textAlign: TextAlign.center,
                      style: kReminderSubtitleTextStyle.copyWith(color: kDarkTealColor, fontSize: 16),
                    ),
                  ),
                ],
              ),
              Container(height: MediaQuery.of(context).size.height/3, child: VerticalDivider(color: kDarkTealColor)),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom:10.0),
                    child: Icon(
                      Icons.remove_red_eye,
                      size: 60,
                      color: kDarkTealColor,
                    ),
                  ),
                  RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(children: [
                        TextSpan(
                            text: 'Right\t',
                            style: kDashboardTitleTextStyle.copyWith(
                                color: kTealColor)),
                        TextSpan(
                          text: 'Eye',
                          style: kDashboardTitleTextStyle.copyWith(
                              color: kTealColor),
                        ),

                      ])),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Your right eye\n suffers from\n $rightResult',
                      textAlign: TextAlign.center,
                      style: kReminderSubtitleTextStyle.copyWith(color: kDarkTealColor, fontSize: 16),
                    ),
                  ),
                ],
              ),

            ],
          ),
        ),
        Expanded(
          child: Container(),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      /// TODO : refine
                      while (Navigator.canPop(context)){
                        Navigator.pop(context);
                      }
                      //Navigator.pushNamed(context, Dashboard.id);
                    },
                    child: Icon(
                      Icons.delete,
                      color: kTealColor,
                      size: 42.0,
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    'Delete Results',
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
                      /// TODO : Implement
                    },
                    child: Icon(
                      Icons.download_rounded,
                      color: kTealColor,
                      size: 42.0,
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    'Download PDF',
                    style: kDashboardButtonLabelStyle,
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20.0,
        ),

      ]),
    ));
  }
}
