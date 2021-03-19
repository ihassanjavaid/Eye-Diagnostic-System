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

class AstigmatismTestScreen extends StatefulWidget {
  static const String id = 'astigmatism_test_screen';
  final EyeType eyeType;

  const AstigmatismTestScreen({Key key, this.eyeType}) : super(key: key);

  @override
  _AstigmatismTestScreen createState() => _AstigmatismTestScreen();
}

class _AstigmatismTestScreen extends State<AstigmatismTestScreen> {
  String astigCircle =
      'assets/images/vision_testing/astigmatism_tests/circle_astig.png';
  String astigSun = 'assets/images/vision_testing/astigmatism_tests/astigmatism sun.png';
  String astigProt = 'assets/images/vision_testing/astigmatism_tests/astigProc.png';
  String astigBox = 'assets/images/vision_testing/astigmatism_tests/astig_box.png';



  String image = '';
  int _pressed = 0;



  String imageProgression(int pressed) {
    if(_pressed ==0){
      return astigCircle;
    }
    else if(_pressed ==1 ){
      return astigSun;
    }
    else if(_pressed ==2){
      return astigProt;
    }
    else if(_pressed ==3){
      return astigBox;
    }
    else{
      return astigCircle;
    }
  }



  Widget _buildImageBox(image){
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10),
      child: Container(
        height: MediaQuery.of(context).size.height / 2.25,
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
                              text: 'Astigmatism\t',
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
            _buildImageBox(imageProgression(_pressed)),
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
                      if(widget.eyeType == EyeType.RIGHT && _pressed >=3){
                        AlertWidget().generateAstigEyeAlert(context: context, title: "Cover Right Eye", description: "Please repeat the test with your right eye covered").show();
                      }
                      if(widget.eyeType == EyeType.LEFT && _pressed>=3){
                        Navigator.pop(context);
                        Navigator.pop(context);
                        Navigator.pop(context);

                        Navigator.push(context, MaterialPageRoute(builder: (context) => VisionResultScreen(
                          testType: VisionTestType.ASTIG,
                        )));

                      }
                      setState(() {
                        _pressed+=1;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: kTealColor.withOpacity(0.8)
                      ),
                      height: 100,
                      width: 150,
                      child: Center(
                        child: Container(
                          padding: EdgeInsets.all(10),
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
                  GestureDetector(
                    onTap: (){
                      if(widget.eyeType == EyeType.RIGHT && _pressed >=3){
                      AlertWidget().generateAstigEyeAlert(context: context, title: "Cover Right Eye", description: "Please repeat the test with your right eye covered").show();
                      }
                      if(widget.eyeType == EyeType.LEFT && _pressed>=3){
                        Navigator.pop(context);
                        Navigator.pop(context);
                        Navigator.pop(context);
                        Navigator.push(context, MaterialPageRoute(builder: (context) => VisionResultScreen(
                          testType: VisionTestType.ASTIG,
                        )));
                      }
                      if(widget.eyeType == EyeType.RIGHT){
                        Provider.of<ProviderData>(context, listen: false).updateRight();
                        print(Provider.of<ProviderData>(context,listen:false).right);
                      }
                      else if(widget.eyeType == EyeType.LEFT){
                        Provider.of<ProviderData>(context, listen: false).updateLeft();
                        print(Provider.of<ProviderData>(context,listen:false).left);
                      }
                      setState(() {
                        _pressed+=1;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: kTealColor.withOpacity(0.8)
                      ),
                      height: 100,
                      width: 150,
                      child: Center(
                        child: Container(
                          padding: EdgeInsets.all(10),
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
