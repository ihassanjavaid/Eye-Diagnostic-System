import 'dart:async';
import 'dart:math';
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

class AcuityTestScreen extends StatefulWidget {
  static const String id = 'acuity_test_screen';
  final EyeType eyeType;

  const AcuityTestScreen({Key key, this.eyeType}) : super(key: key);

  @override
  _AcuityTestScreen createState() => _AcuityTestScreen();
}

class _AcuityTestScreen extends State<AcuityTestScreen> {

 // 0: up, 1: down, 2: left, 3: right
  List <String> letters = ['assets/images/vision_testing/instructions_icons/e-open-up.png',
    'assets/images/vision_testing/instructions_icons/e-open-down.png',
    'assets/images/vision_testing/instructions_icons/e-open-left.png',
    'assets/images/vision_testing/instructions_icons/e-open-right.png'];

  String image = '';
  int _pressed = 0;
  int direction = 0;
  int _correct = 0;
  int _incorrect = 0;
  double _height = 200;
  double _width = 200;

  int radomizer(){
    Random random = new Random();
    int num = random.nextInt(4);
    return num;
  }


  String imageProgression(int num) {
    if(num ==0){
      direction = 0;
      return letters[0];
    }
    else if(num ==1 ){
      direction = 1;
      return letters[1];
    }
    else if(num ==2){
      direction = 2;
      return letters[2];
    }
    else if(num ==3){
      direction = 3;
      return letters[3];
    }
    else{
      direction = 0;
      return letters[0];
    }
  }



  Widget _buildImageBox(image){
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10),
      child: Image(
        height: _height,
        width: _width,
        image: AssetImage(image),
        fit: BoxFit.contain,
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
                              text: 'Visual\tAcuity\t',
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
              height: MediaQuery.of(context).size.height/7,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Center(
                child: GestureDetector(
                  onTap: (){
                    if(widget.eyeType ==EyeType.RIGHT){
                      if(_incorrect>=3){
                        AlertWidget().generateAcuityEyeAlert(context: context, title: "Cover Right Eye", description: "Please repeat the test with your right eye covered").show();
                      }
                      if(_correct>=3){
                        if(_height >25 && _width >25){
                          _height = _height/2;
                          _width = _width/2;
                          setState(() {
                            _correct = 0;
                            _incorrect = 0;
                            _pressed = 0;
                          });
                        }
                        else{
                          AlertWidget().generateAcuityEyeAlert(context: context, title: "Cover Right Eye", description: "Please repeat the test with your right eye covered").show();
                        }
                        setState(() {
                          _correct = 0;
                          _incorrect = 0;
                          _pressed = 0;
                        });
                      }
                      if(direction == 0){
                        _correct +=1;
                        _pressed +=1;
                        Provider.of<ProviderData>(context, listen: false).updateRightCorrect();
                        print('Right Eye Correct: ' + Provider.of<ProviderData>(context,listen: false).rightCorrect.toString());
                        setState((){});
                      }
                      else if(direction != 0){
                        Provider.of<ProviderData>(context, listen: false).updateRightIncorrect();
                        print('Right Eye Incorrect: ' + Provider.of<ProviderData>(context,listen: false).rightIncorrect.toString());
                        _incorrect+=1;
                        _pressed +=1;
                        setState(() {  });
                      }
                    }
                    else if(widget.eyeType == EyeType.LEFT){
                      if(_incorrect >= 3) {
                        Navigator.pop(context);
                        Navigator.pop(context);
                        Navigator.pop(context);
                        Navigator.push(context, MaterialPageRoute(builder: (
                            context) =>
                            VisionResultScreen(
                              testType: VisionTestType.ACUITY,
                            )));
                      }
                        else if(_correct >=3){
                        if(_height >25 && _width >25){
                          _height = _height/2;
                          _width = _width/2;
                        }
                        else{
                          Navigator.pop(context);
                          Navigator.pop(context);
                          Navigator.pop(context);
                          Navigator.push(context, MaterialPageRoute(builder: (
                              context) =>
                              VisionResultScreen(
                                testType: VisionTestType.ACUITY,
                              )));
                        }

                        setState(() {
                          _correct = 0;
                          _incorrect = 0;
                          _pressed = 0;
                        });
                      }
                        else if(direction == 0){
                        _correct +=1;
                        _pressed +=1;
                        Provider.of<ProviderData>(context, listen: false).updateLeftCorrect();
                        print('Left Eye Correct: ' + Provider.of<ProviderData>(context,listen: false).leftCorrect.toString());
                        setState(() {  });
                      }
                      else if(direction !=0){
                        Provider.of<ProviderData>(context, listen: false).updateLeftIncorrect();
                        print('Left Eye Incorrect: ' + Provider.of<ProviderData>(context,listen: false).leftIncorrect.toString());
                        _incorrect+=1;
                        _pressed +=1;
                        setState(() { });
                      }
                      setState(() {});
                    }
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
                      width: 90,
                      child: Center(
                        child: Container(
                          //padding: EdgeInsets.only(top: 6.0),
                          child: Icon(
                            Icons.keyboard_arrow_up,
                            color: kScaffoldBackgroundColor,
                              size: 50,
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
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: (){
                      if(widget.eyeType ==EyeType.RIGHT){
                        if(_incorrect>=3){
                          AlertWidget().generateAcuityEyeAlert(context: context, title: "Cover Right Eye", description: "Please repeat the test with your right eye covered").show();
                        }
                        if(_correct>=3){
                          if(_height >25 && _width >25){
                            _height = _height/2;
                            _width = _width/2;
                            setState(() {
                              _correct = 0;
                              _incorrect = 0;
                              _pressed = 0;
                            });
                          }
                          else{
                            AlertWidget().generateAcuityEyeAlert(context: context, title: "Cover Right Eye", description: "Please repeat the test with your right eye covered").show();
                          }
                          setState(() {
                            _correct = 0;
                            _incorrect = 0;
                            _pressed = 0;
                          });
                        }
                        if(direction == 2){
                          _correct +=1;
                          _pressed +=1;
                          Provider.of<ProviderData>(context, listen: false).updateRightCorrect();
                          print('Right Eye Correct: ' + Provider.of<ProviderData>(context,listen: false).rightCorrect.toString());
                          setState((){});
                        }
                        else if(direction != 2){
                          Provider.of<ProviderData>(context, listen: false).updateRightIncorrect();
                          print('Right Eye Incorrect: ' + Provider.of<ProviderData>(context,listen: false).rightIncorrect.toString());
                          _incorrect+=1;
                          _pressed +=1;
                          setState(() {  });
                        }
                      }
                      else if(widget.eyeType == EyeType.LEFT){
                        if(_incorrect >=3) {
                          Navigator.pop(context);
                          Navigator.pop(context);
                          Navigator.pop(context);
                          Navigator.push(context, MaterialPageRoute(builder: (
                              context) =>
                              VisionResultScreen(
                                testType: VisionTestType.ACUITY,
                              )));
                        }
                        else if(_correct >=3){
                          if(_height >25 && _width >25){
                            _height = _height/2;
                            _width = _width/2;
                          }
                          else{
                            Navigator.pop(context);
                            Navigator.pop(context);
                            Navigator.pop(context);
                            Navigator.push(context, MaterialPageRoute(builder: (
                                context) =>
                                VisionResultScreen(
                                  testType: VisionTestType.ACUITY,
                                )));
                          }

                          setState(() {
                            _correct = 0;
                            _incorrect = 0;
                            _pressed = 0;
                          });
                        }
                        else if(direction == 2){
                          _correct +=1;
                          _pressed +=1;
                          Provider.of<ProviderData>(context, listen: false).updateLeftCorrect();
                          print('Left Eye Correct: ' + Provider.of<ProviderData>(context,listen: false).leftCorrect.toString());
                          setState(() {  });
                        }
                        else if (direction !=2){
                          Provider.of<ProviderData>(context, listen: false).updateLeftIncorrect();
                          print('Left Eye Incorrect: ' + Provider.of<ProviderData>(context,listen: false).leftIncorrect.toString());
                          _incorrect+=1;
                          _pressed +=1;
                          setState(() { });
                        }
                        setState(() {});
                      }
                    },
                    child: Material(
                      elevation: 10.0,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: kTealColor.withOpacity(0.8)
                        ),
                        height: 90,
                        width: 60,
                        child: Center(
                          child: Container(
                            child: Icon(
                              Icons.keyboard_arrow_left,
                              color: kScaffoldBackgroundColor,
                              size: 50,
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
                  Container(
                    width: 200, height: 200,
                      child: Center(
                          child: _buildImageBox(imageProgression(radomizer()))
                      )
                  ),
                  GestureDetector(
                    onTap: (){
                      if(widget.eyeType ==EyeType.RIGHT){
                        if(_incorrect>=3){
                          AlertWidget().generateAcuityEyeAlert(context: context, title: "Cover Right Eye", description: "Please repeat the test with your right eye covered").show();
                        }
                        if(_correct>=3){
                          if(_height >25 && _width >25){
                            _height = _height/2;
                            _width = _width/2;
                            setState(() {
                              _correct = 0;
                              _incorrect = 0;
                              _pressed = 0;
                            });
                          }
                          else{
                            AlertWidget().generateAcuityEyeAlert(context: context, title: "Cover Right Eye", description: "Please repeat the test with your right eye covered").show();
                          }
                          setState(() {
                            _correct = 0;
                            _incorrect = 0;
                            _pressed = 0;
                          });
                        }
                        if(direction == 3){
                          _correct +=1;
                          _pressed +=1;
                          Provider.of<ProviderData>(context, listen: false).updateRightCorrect();
                          print('Right Eye Correct: ' + Provider.of<ProviderData>(context,listen: false).rightCorrect.toString());
                          setState((){});
                        }
                        else if(direction != 3){
                          Provider.of<ProviderData>(context, listen: false).updateRightIncorrect();
                          print('Right Eye Incorrect: ' + Provider.of<ProviderData>(context,listen: false).rightIncorrect.toString());
                          _incorrect+=1;
                          _pressed +=1;
                          setState(() {  });
                        }
                      }
                      else if(widget.eyeType == EyeType.LEFT){
                        if(_incorrect >= 3) {
                          Navigator.pop(context);
                          Navigator.pop(context);
                          Navigator.pop(context);
                          Navigator.push(context, MaterialPageRoute(builder: (
                              context) =>
                              VisionResultScreen(
                                testType: VisionTestType.ACUITY,
                              )));
                        }
                        else if(_correct >=3){
                          if(_height >25 && _width >25){
                            _height = _height/2;
                            _width = _width/2;
                          }
                          else{
                            Navigator.pop(context);
                            Navigator.pop(context);
                            Navigator.pop(context);
                            Navigator.push(context, MaterialPageRoute(builder: (
                                context) =>
                                VisionResultScreen(
                                  testType: VisionTestType.ACUITY,
                                )));
                          }

                          setState(() {
                            _correct = 0;
                            _incorrect = 0;
                            _pressed = 0;
                          });
                        }
                        else if(direction == 3){
                          _correct +=1;
                          _pressed +=1;
                          Provider.of<ProviderData>(context, listen: false).updateLeftCorrect();
                          print('Left Eye Correct: ' + Provider.of<ProviderData>(context,listen: false).leftCorrect.toString());
                          setState(() {  });
                        }
                        else if(direction!=3){
                          Provider.of<ProviderData>(context, listen: false).updateLeftIncorrect();
                          print('Left Eye Incorrect: ' + Provider.of<ProviderData>(context,listen: false).leftIncorrect.toString());
                          _incorrect+=1;
                          _pressed +=1;
                          setState(() { });
                        }
                        setState(() {});
                      }
                    },
                    child: Material(
                      elevation: 10.0,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: kTealColor.withOpacity(0.8)
                        ),
                        height: 90,
                        width: 60,
                        child: Center(
                          child: Container(
                            child: Icon(
                              Icons.keyboard_arrow_right,
                              color: kScaffoldBackgroundColor,
                              size: 50,
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
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: (){
                      if(widget.eyeType ==EyeType.RIGHT){
                        if(_incorrect>=3){
                          AlertWidget().generateAcuityEyeAlert(context: context, title: "Cover Right Eye", description: "Please repeat the test with your right eye covered").show();
                        }
                        if(_correct>=3){
                          if(_height >25 && _width >25){
                            _height = _height/2;
                            _width = _width/2;
                            setState(() {
                              _correct = 0;
                              _incorrect = 0;
                              _pressed = 0;
                            });
                          }
                          else{
                            AlertWidget().generateAcuityEyeAlert(context: context, title: "Cover Right Eye", description: "Please repeat the test with your right eye covered").show();
                          }
                          setState(() {
                            _correct = 0;
                            _incorrect = 0;
                            _pressed = 0;
                          });
                        }
                        if(direction == 1){
                          _correct +=1;
                          _pressed +=1;
                          Provider.of<ProviderData>(context, listen: false).updateRightCorrect();
                          print('Right Eye Correct: ' + Provider.of<ProviderData>(context,listen: false).rightCorrect.toString());
                          setState((){});
                        }
                        else if(direction != 1){
                          Provider.of<ProviderData>(context, listen: false).updateRightIncorrect();
                          print('Right Eye Incorrect: ' + Provider.of<ProviderData>(context,listen: false).rightIncorrect.toString());
                          _incorrect+=1;
                          _pressed +=1;
                          setState(() {  });
                        }
                      }
                      else if(widget.eyeType == EyeType.LEFT){
                        if(_incorrect >= 3) {
                          Navigator.pop(context);
                          Navigator.pop(context);
                          Navigator.pop(context);
                          Navigator.push(context, MaterialPageRoute(builder: (
                              context) =>
                              VisionResultScreen(
                                testType: VisionTestType.ACUITY,
                              )));
                        }
                        else if(_correct >=3){
                          if(_height >25 && _width >25){
                            _height = _height/2;
                            _width = _width/2;
                          }
                          else{
                            Navigator.pop(context);
                            Navigator.pop(context);
                            Navigator.pop(context);
                            Navigator.push(context, MaterialPageRoute(builder: (
                                context) =>
                                VisionResultScreen(
                                  testType: VisionTestType.ACUITY,
                                )));
                          }

                          setState(() {
                            _correct = 0;
                            _incorrect = 0;
                            _pressed = 0;
                          });
                        }
                        else if(direction == 1){
                          _correct +=1;
                          _pressed +=1;
                          Provider.of<ProviderData>(context, listen: false).updateLeftCorrect();
                          print('Left Eye Correct: ' + Provider.of<ProviderData>(context,listen: false).leftCorrect.toString());
                          setState(() {  });
                        }
                        else if (direction !=1){
                          Provider.of<ProviderData>(context, listen: false).updateLeftIncorrect();
                          print('Left Eye Incorrect: ' + Provider.of<ProviderData>(context,listen: false).leftIncorrect.toString());
                          _incorrect+=1;
                          _pressed +=1;
                          setState(() { });
                        }
                        setState(() {});
                      }
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
                        width: 90,
                        child: Center(
                          child: Container(

                            child: Icon(
                              Icons.keyboard_arrow_down,
                              color: kScaffoldBackgroundColor,
                              size: 50,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
