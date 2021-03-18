import 'package:eye_diagnostic_system/utilities/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DuochromeTestScreen extends StatefulWidget {
  static const String id = 'duochrome_test_screen';
  @override
  _DuochromeTestScreen createState() => _DuochromeTestScreen();
}

class _DuochromeTestScreen extends State<DuochromeTestScreen> {
  String hyperopiaGreen01 = 'assets/images/vision_testing/duo-chrome tests/green01.png';
  String hyperopiaGreen02 = 'assets/images/vision_testing/duo-chrome tests/green02.png';
  String hyperopiaYellow01 = 'assets/images/vision_testing/duo-chrome tests/yellow01.png';
  String hyperopiaYellow02 = 'assets/images/vision_testing/duo-chrome tests/yellow02.png';

  String myopiaRed01 = 'assets/images/vision_testing/duo-chrome tests/red01.png';
  String myopiaRed02 = 'assets/images/vision_testing/duo-chrome tests/red02.png';
  String myopiaOrange01 = 'assets/images/vision_testing/duo-chrome tests/orange01.png';
  String myopiaOrange02 = 'assets/images/vision_testing/duo-chrome tests/orange02.png';

  String myopiaImage = '';
  String hyperopiaImage = '';

  int hyperopiaPressed = 0;
  int myopiaPressed = 0;

  String imageProgressionHyper(int pressed){
    if (pressed == 0){
      hyperopiaImage = hyperopiaGreen01;
    }
    else if(pressed == 1){
      hyperopiaImage = hyperopiaGreen02;
    }
    else if(pressed == 2){
      hyperopiaImage = hyperopiaYellow01;
    }
    else{
      hyperopiaImage = hyperopiaYellow02;
    }

    return hyperopiaImage;
  }
  String imageProgressionMyopia(int pressed){
    if (pressed == 0){
      myopiaImage = myopiaRed01;
    }
    else if(pressed == 1){
      myopiaImage = myopiaRed02;
    }
    else if(pressed == 2){
      myopiaImage = myopiaOrange01;
    }
    else{
      myopiaImage = myopiaOrange02;
    }

    return myopiaImage;
  }

  Widget _buildTopBox(image) {
    return Container(
      height: MediaQuery.of(context).size.height / 2.15,
      width: double.infinity,
      child: FittedBox(
        child: Image(
          image: AssetImage(image),
        ),
        fit: BoxFit.fill,
      ),
    );
  }

  Widget _buildMiddlePanel() {
    return Container(
      color: kScaffoldBackgroundColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Both Appear the Same',
            style: kOnBoardingSubtitleStyle. copyWith(color: Colors.black87, fontSize: 30),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBox(image) {
    return Container(
      height: MediaQuery.of(context).size.height / 2.15,
      width: double.infinity,
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
    myopiaImage = myopiaRed01;
   // hyperopiaImage = hyperopiaGreen01;
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Column(
          children: [
            GestureDetector(
              child: _buildTopBox(imageProgressionHyper(hyperopiaPressed)),
              onTap: () {
                hyperopiaPressed = hyperopiaPressed + 1;
                setState(() {
                  print(hyperopiaImage);
                  hyperopiaImage = imageProgressionHyper(hyperopiaPressed);
                  print(hyperopiaImage);
                });
              },
            ),
            GestureDetector(
              child: _buildMiddlePanel(),
              onTap: (){
                hyperopiaPressed += 1;
                myopiaPressed += 1;
                setState(() {
                  myopiaImage = imageProgressionMyopia(myopiaPressed);
                  hyperopiaImage = imageProgressionHyper(hyperopiaPressed);
                });
              },
            ),
            Expanded(
              child: GestureDetector(
                child: _buildBottomBox(imageProgressionMyopia(myopiaPressed)),
                onTap: () {
                  myopiaPressed = myopiaPressed + 1;
                  setState(() {
                    myopiaImage = imageProgressionMyopia(myopiaPressed);
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
