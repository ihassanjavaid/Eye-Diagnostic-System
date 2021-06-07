import 'dart:io';

import 'package:eye_diagnostic_system/screens/diagnosis_screens/diagnosis_loading_screen.dart';
import 'package:eye_diagnostic_system/utilities/constants.dart';
import 'package:flutter/material.dart';

class CapturedScreen extends StatelessWidget {
  static const String id = 'captured_screen';

  final DiagnosisType diagnosisType;
  final File image;

  const CapturedScreen({Key key, @required this.diagnosisType, @required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            // width: size.width,
            // height: size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: FileImage(image)
              )
            ),
            //child: Image.file(image),
          ),
          Positioned(
            bottom: size.height/12 - 32,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Container(
                      height: 70,
                      width: 70,
                      child: FittedBox(
                        child: FloatingActionButton(
                          // hero tag because for multiple floating action buttons
                          // there should be different hero tags
                          heroTag: 'back',
                          backgroundColor: kScaffoldBackgroundColor,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.refresh,
                            color: kTealColor,
                            size: 30.0,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 12.0),
                      child: Text(
                        'Retake',
                        style: kBottomNavBarTextStyle.copyWith(color: kAmberColor, fontSize: 20),
                      ),
                    )
                  ],
                ),
                Column(
                  children: [
                    Container(
                      height: 70,
                      width: 70,
                      child: FittedBox(
                        child: FloatingActionButton(
                          heroTag: 'send',
                          backgroundColor: kScaffoldBackgroundColor,
                          onPressed: () {
                            // Send to server
                            Navigator.push(context, MaterialPageRoute(builder: (context) => DiagnosisLoadingScreen(
                              diagnosisType: diagnosisType,
                              image: image,
                            )));
                          },
                          child: Icon(
                            Icons.send,
                            color: kTealColor,
                            size: 28.0,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 12.0),
                      child: Text(
                        'Proceed',
                        style: kBottomNavBarTextStyle.copyWith(color: kAmberColor, fontSize: 20),
                      ),
                    )
                  ],
                ),
                // GestureDetector(
                //   onTap: () {
                //   },
                //   child: Icon(
                //     Icons.menu,
                //     color: kTealColor,
                //     size: 30.0,
                //   ),
                // ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
