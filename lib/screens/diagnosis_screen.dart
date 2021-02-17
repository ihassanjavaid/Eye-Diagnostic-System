import 'dart:async';
import 'package:eye_diagnostic_system/screens/diagnosis_screens/image_picker_screen.dart';
import 'package:eye_diagnostic_system/screens/diagnosis_screens/reporting_screen.dart';
import 'package:eye_diagnostic_system/services/server_service.dart';
import 'package:eye_diagnostic_system/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:eye_diagnostic_system/screens/diagnosis_screens/camera_screen.dart';
import 'package:camera/camera.dart';
import 'package:eye_diagnostic_system/screens/fetching_results_screen.dart';
import 'package:eye_diagnostic_system/services/screen_arguments.dart';

class DiagnosisScreen extends StatefulWidget {
  static const String id = 'diagnosis_screen';

  @override
  _DiagnosisScreenState createState() => _DiagnosisScreenState();
}

class _DiagnosisScreenState extends State<DiagnosisScreen> {
  Timer _timer;
  double _circleWidth = 3.5;

  Server _server = Server();

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
            Center(
              child: RichText(
                text: TextSpan(children: [
                  TextSpan(
                    text: 'EyeSee\t',
                    style: kDashboardTitleTextStyle.copyWith(color: kTealColor),
                  ),
                  TextSpan(
                    text: 'Diagnostics',
                    style: kDashboardTitleTextStyle.copyWith(color: kTealColor),
                  ),
                ]),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        final cameras = await availableCameras();
                        final firstCamera = cameras.first;

                        Navigator.push(context,
                            MaterialPageRoute(builder: (BuildContext context) => CameraScreen(
                              camera: firstCamera,
                              diagnosisType: DiagnosisType.DISEASE,
                            ))
                        );
                        //Navigator.pushNamed(context, ReportingScreen.id);
                        // Navigator.pushNamed(context,
                        //     CameraScreen.id,
                        //     arguments: CameraScreenArguments(firstCamera, DiagnosisType.DISEASE)
                        // );

                      },
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
                      'Disease',
                      style: kDashboardButtonLabelStyle,
                    ),
                    Text(
                      'Diagnosis',
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
                      onTap: () async {

                        /// TODO : Testing only, remove from here
                        //Navigator.pushNamed(context, ReportingScreen.id);

                        // Initialize Camera
                        // final cameras = await availableCameras();
                        // final firstCamera = cameras.first;
                        //
                        // Navigator.push(context,
                        // MaterialPageRoute(builder: (BuildContext context) => CameraScreen(
                        //   camera: firstCamera,
                        // ))
                        // );
                      },
                      child: Icon(
                        FontAwesomeIcons.eye,
                        color: kTealColor,
                        size: 50.0,
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      'Disorder',
                      style: kDashboardButtonLabelStyle,
                    ),
                    Text(
                      'Identification',
                      style: kDashboardButtonLabelStyle,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        try{
                          //await _server.checkServerConnection();
                        }
                        catch (err){
                          print('here');
                          ScaffoldMessenger.of(context).showSnackBar(errorSnackBar);
                        }
                      },
                      child: Icon(
                        FontAwesomeIcons.disease,
                        color: kTealColor,
                        size: 50.0,
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      'Infection',
                      style: kDashboardButtonLabelStyle,
                    ),
                    Text(
                      'Prognosis',
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
                        //Navigator.pushNamed(context, FetchingResultsScreen.id);
                        Navigator.pushNamed(context,
                            ImagePickerScreen.id,
                            arguments: ImagePickerScreenArguments(DiagnosisType.FUNDUS)
                        );

                      },
                      child: Icon(
                        FontAwesomeIcons.starOfLife,
                        color: kTealColor,
                        size: 50.0,
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      'Fundus',
                      style: kDashboardButtonLabelStyle,
                    ),
                    Text(
                      '  Analysis  ',
                      style: kDashboardButtonLabelStyle,
                    ),
                  ],
                )
              ],
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
