import 'dart:async';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:eye_diagnostic_system/components/header_clipper_component.dart';
import 'package:eye_diagnostic_system/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:camera/camera.dart';
import 'package:eye_diagnostic_system/services/screen_arguments.dart';

import 'image_picker_screen.dart';


class CameraScreen extends StatefulWidget {
  static const String id = 'camera_screen';

  final CameraDescription camera;


  const CameraScreen({
    Key key,
    @required this.camera,
  }) : super(key: key);

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController _controller;
  Future<void> _initializeControllerFuture;
  double _containerHeight;

  @override
  void initState() {
    super.initState();
    _containerHeight = 160;
    // To display the current output from the camera,
    // create a CameraController.
    _controller = CameraController(
      // Get a specific camera from the list of available cameras.
      widget.camera,
      // Define the resolution to use.
      ResolutionPreset.ultraHigh,
    );
    // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = _controller.initialize();
    _hideHeader();
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ScreenArguments screenArgs = ModalRoute.of(context).settings.arguments;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kScaffoldBackgroundColor,
      /*body: Container(
        color: kScaffoldBackgroundColor,
        child: Column(
          children: [
            ClipPath(
              clipper: HeaderCustomClipper(),
              child: Container(
                width: double.infinity,
                height: 160,
                color: kTealColor,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 35.0, bottom: 10.0),
                      child: RichText(
                        text: TextSpan(children: [
                          TextSpan(
                            text: 'EyeSee\t',
                            style: kDashboardTitleTextStyle.copyWith(
                                color: kAmberColor),
                          ),
                          TextSpan(
                            text: 'Cam',
                            style: kDashboardTitleTextStyle.copyWith(
                                color: kAmberColor),
                          ),
                        ]),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Text(
                          "${DateFormat('EEEE').format(DateTime.now())}, ${DateFormat('jm').format(DateTime.now())}",
                          style: kDashboardTitleTextStyle.copyWith(
                              fontSize: 20.0)),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Container(
                  height: MediaQuery.of(context).size.height - 280,
                  width: MediaQuery.of(context).size.width - 20,
                  child: getCameraPreview()
                ),
              ),
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
                        },
                        child: Icon(
                          Icons.photo,
                          color: kTealColor,
                          size: 30.0,
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        'Gallery',
                        style: kDashboardButtonLabelStyle,
                      ),
                    ],
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 6,
                  ),
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                        },
                        child: Icon(
                          Icons.camera,
                          color: kTealColor,
                          size: 58.0,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 6,
                  ),
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                        },
                        child: Icon(
                          Icons.menu,
                          color: kTealColor,
                          size: 30.0,
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        'Files',
                        style: kDashboardButtonLabelStyle,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),*/
      floatingActionButton: Container(
        height: 132.0,
        width: 132.0,
        child: FittedBox(
          child: AvatarGlow(
            endRadius: 48.0,
            child: FloatingActionButton(
              backgroundColor: kScaffoldBackgroundColor,
              onPressed: () {  },
              child: Icon(
                Icons.camera,
                color: kTealColor,
                size: 50.0,
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: GestureDetector(
        /*onVerticalDragStart: (det){
          setState(() {
            _containerHeight = 160;
            _hideHeader();
          });
        },*/
        onVerticalDragUpdate: (det){
          setState(() {
            _containerHeight = 160;
          });
          _hideHeader();
        },
        child: Stack(
          children: [
            Container(
              height: size.height,
              width: size.height,
              child: _getCameraPreview(),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: AnimatedContainer(
                curve: Curves.decelerate,
                height: _containerHeight,
                duration: Duration(milliseconds: 500),
                child: ClipPath(
                  clipper: HeaderCustomClipper(),
                  child: Container(
                    width: double.infinity,
                    height: 160,
                    color: kTealColor,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 35.0, bottom: 10.0),
                          child: RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                text: 'EyeSee\t',
                                style: kDashboardTitleTextStyle.copyWith(
                                    color: kAmberColor),
                              ),
                              TextSpan(
                                text: 'Cam',
                                style: kDashboardTitleTextStyle.copyWith(
                                    color: kAmberColor),
                              ),
                            ]),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(bottom: 10),
                          child: Text(
                              "${DateFormat('EEEE').format(DateTime.now())}, ${DateFormat('jm').format(DateTime.now())}",
                              style: kDashboardTitleTextStyle.copyWith(
                                  fontSize: 20.0)),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: size.height/12 - 12,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  FloatingActionButton(
                    // hero tag because for multiple floating action buttons
                    // there should be different hero tags
                    heroTag: 'photos',
                    backgroundColor: kScaffoldBackgroundColor,
                    onPressed: () {
                      print("opening gallery");
                      Navigator.pushNamed(context,
                          ImagePickerScreen.id,
                          arguments: ScreenArguments(screenArgs.diagnosisType)
                      );
                    },
                    child: Icon(
                      Icons.photo,
                      color: kTealColor,
                      size: 30.0,
                    ),
                  ),
                  FloatingActionButton(
                    heroTag: 'menu',
                    backgroundColor: kScaffoldBackgroundColor,
                    onPressed: () {  },
                    child: Icon(
                      Icons.menu,
                      color: kTealColor,
                      size: 30.0,
                    ),
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
      ),
    );
  }

  Widget _getCameraPreview(){
    return FutureBuilder<void>(
      future: _initializeControllerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          // If the Future is complete, display the preview.
          return CameraPreview(_controller);
        } else {
          // Otherwise, display a loading indicator.
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  void _hideHeader(){
    Future.delayed(const Duration(seconds: 4), () {
      setState(() {
        _containerHeight = 0;
      });
    });
  }
}
