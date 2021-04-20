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

class MyopiaTestScreen extends StatefulWidget {
  static const String id = 'myopia_test_screen';
  final EyeType eyeType;

  const MyopiaTestScreen({Key key, this.eyeType}) : super(key: key);

  @override
  _MyopiaTestScreen createState() => _MyopiaTestScreen();
}

class _MyopiaTestScreen extends State<MyopiaTestScreen> {
  String sentence = 'The\nQuick\nBrown\nFox';



  String image = '';
  int _pressed = 0;



  double textProgression(int pressed) {
    if(_pressed ==0){
      return 85;
    }
    else if(_pressed ==1 ){
      return 42;
    }
    else if(_pressed ==2){
      return 30;
    }
    else if(_pressed ==3){
      return 22;
    }
    else if(_pressed ==4){
      return 17;
    }
    else if(_pressed ==5){
      return 13;
    }
    else if(_pressed ==6){
      return 9;
    }
    else{
      return 85;
    }
  }

  double getLogMAR(){
    if(_pressed ==0){
      return 1.0;
    }
    else if(_pressed ==1 ){
      return 0.7;
    }
    else if(_pressed ==2){
      return 0.55;
    }
    else if(_pressed ==3){
      return 0.4;
    }
    else if(_pressed ==4){
      return 0.3;
    }
    else if(_pressed ==5){
      return 0.2;
    }
    else if(_pressed ==6){
      return 0;
    }
    else{
      return 1.0;
    }
  }



  Widget _buildSentenceBox(){
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Center(
        child: Container(
          height: MediaQuery.of(context).size.height / 2.25,
          width: MediaQuery.of(context).size.width / 1.15,
          child: SizedBox(
            child: Center(
              child: Text(
                sentence,
                textAlign: TextAlign.center,
                style: (
                kDashboardTitleTextStyle.copyWith(fontSize: textProgression(_pressed), color: kDarkTealColor, wordSpacing: 5.0)
                ),
              ),
            ),
           // fit: BoxFit.fill,
          ),
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
                              text: 'Myopia\t',
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
            SizedBox(
              height: 40,
            ),
            _buildSentenceBox(),
            Expanded(
              child:Container(),
            ),
            Padding(
              padding: const EdgeInsets.only(left:25.0, right: 25.0, bottom: 40.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: (){
                      if(widget.eyeType == EyeType.RIGHT && _pressed >=6){
                        AlertWidget().generateMyopiaEyeAlert(context: context, title: "Cover Right Eye", description: "Please repeat the test with your right eye covered").show();
                      }
                      if(widget.eyeType == EyeType.LEFT && _pressed>=6){
                        Navigator.pop(context);
                        Navigator.pop(context);
                        Navigator.pop(context);

                        Navigator.push(context, MaterialPageRoute(builder: (context) => VisionResultScreen(
                          testType: VisionTestType.MYOPIA,
                        )));

                      }
                      setState(() {
                        _pressed+=1;
                      });
                    },
                    child: Material(
                      elevation: 10.0,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: kTealColor.withOpacity(0.8)
                        ),
                        height: 60,
                        width: 150,
                        child: Center(
                          child: Container(
                            padding: EdgeInsets.only(top: 6.0),
                            child: Text(
                              'Clear',
                              style: kDashboardButtonLabelStyle.copyWith(color: kScaffoldBackgroundColor, fontSize: 34),
                            ),
                            // child: AutoSizeText(
                            //   'This test checks visionary health',
                            //   style: kDashboardButtonLabelStyle.copyWith(fontSize: 20),
                            // ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      // if(widget.eyeType == EyeType.RIGHT && _pressed >=7){
                      //   AlertWidget().generateMyopiaEyeAlert(context: context, title: "Cover Right Eye", description: "Please repeat the test with your right eye covered").show();
                      // }
                      // if(widget.eyeType == EyeType.LEFT && _pressed>=7){
                      //   Navigator.pop(context);
                      //   Navigator.pop(context);
                      //   Navigator.pop(context);
                      //   Navigator.push(context, MaterialPageRoute(builder: (context) => VisionResultScreen(
                      //     testType: VisionTestType.MYOPIA,
                      //   )));
                      // }
                      if(widget.eyeType == EyeType.RIGHT){
                        Provider.of<ProviderData>(context, listen: false).updateRightMy(getLogMAR());
                        print(Provider.of<ProviderData>(context,listen:false).rightMy);
                        AlertWidget().generateMyopiaEyeAlert(context: context, title: "Cover Right Eye", description: "Please repeat the test with your right eye covered").show();
                      }
                      else if(widget.eyeType == EyeType.LEFT){
                        Provider.of<ProviderData>(context, listen: false).updateLeftMy(getLogMAR());
                        print(Provider.of<ProviderData>(context,listen:false).leftMy);
                        Navigator.pop(context);
                        Navigator.pop(context);
                        Navigator.pop(context);
                        Navigator.push(context, MaterialPageRoute(builder: (context) => VisionResultScreen(
                          testType: VisionTestType.MYOPIA,
                        )));
                      }
                      // setState(() {
                      // });
                    },
                    child: Material(
                      elevation: 10.0,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: kTealColor.withOpacity(0.8)
                        ),
                        height: 60,
                        width: 150,
                        child: Center(
                          child: Container(
                            padding: EdgeInsets.only(top: 6.0),
                            child: Text(
                              'Blurry',
                              style: kDashboardButtonLabelStyle.copyWith(color: kScaffoldBackgroundColor, fontSize: 34),
                            ),
                            // child: AutoSizeText(
                            //   'This test checks visionary health',
                            //   style: kDashboardButtonLabelStyle.copyWith(fontSize: 20),
                            // ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
