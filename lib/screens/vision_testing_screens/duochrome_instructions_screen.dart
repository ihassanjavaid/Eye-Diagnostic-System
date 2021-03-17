import 'package:eye_diagnostic_system/screens/login_screen.dart';
import 'package:eye_diagnostic_system/screens/vision_testing_screens/vision_testing_main.dart';
import 'package:eye_diagnostic_system/screens/vision_testing_screens/duochrome_test_screen.dart';
import 'package:eye_diagnostic_system/utilities/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

class DuoChromeInstructionsScreen extends StatefulWidget {
  static const String id = 'duochrome_instructions_screen';

  @override
  _DuoChromeInstructionsScreen createState() => _DuoChromeInstructionsScreen();
}

class _DuoChromeInstructionsScreen extends State<DuoChromeInstructionsScreen> {
  final int _numPages = 7;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: 8.0,
      width: isActive ? 24.0 : 8.0,
      decoration: BoxDecoration(
        color: isActive ? kTealColor : kTealColor.withOpacity(0.5),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Container(
              height: MediaQuery.of(context).size.height / 1.4,
              width: 400,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: kTealColor.withOpacity(0.5)),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        child: FlatButton(
                          onPressed: () {
                            Navigator.popAndPushNamed(context, DuochromeTestScreen.id);
                          },
                          child: Text(
                            'SKIP',
                            style: kBottomNavBarTextStyle.copyWith(
                                color: kLightAmberColor),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  // Expanded(
                  //   child: Container(),
                  // ),
                  Container(
                    height: MediaQuery.of(context).size.height / 2.1,
                    child: PageView(
                      physics: ClampingScrollPhysics(),
                      controller: _pageController,
                      onPageChanged: (int page) {
                        setState(() {
                          _currentPage = page;
                        });
                      },
                      children: <Widget>[
                        buildPageViewBlock(
                            'Duo-Chrome Test',
                            'Instructions',
                            'By testing the pupils\' reaction to different wavelengths of light, this test will determine if you suffer from Myopia or Hyperopia. Please read the following instructions carefully for accurate results',
                            'assets/images/vision_testing/instructions_icons/instructions.png'),
                        buildPageViewBlock(
                            'Step 1,',
                            ' Dilate Pupils',
                            'Step away from light sources in your vicinity. Turn off all lights and close the curtains. Stay in a dark room for 3-5 minutes to dilate your pupils for optimum accuracy',
                            'assets/images/vision_testing/instructions_icons/earth-hour.png'),
                        buildPageViewBlock(
                            'Step 2.',
                            'Eye Wear',
                            'If you wear any form of corrective eye wear such as contact lenses or glasses, keep them in place for the duration of this test',
                            'assets/images/vision_testing/main_icons/eyeglasses.png'),
                        buildPageViewBlock(
                            'Step 3.',
                            'Phone Distance',
                            'In order to simulate this test with your smartphone, please hold the phone at a distance of 1 foot (arm\'s length) away from your face, level with your eyes',
                            'assets/images/vision_testing/instructions_icons/distance.png'),
                        buildPageViewBlock(
                            'Step 4.',
                            'Cover Left Eye',
                            'This test must be iterated twice. First with the right eye covered. Place your free hand to cover your right eye completely. Go through the test with this eye covered.',
                            'assets/images/vision_testing/instructions_icons/right-eye.png'),
                        buildPageViewBlock(
                            'Step 5.',
                            'Cover Right Eye',
                            'After having gone through the test with your left eye covered, now repeat the test again with your right eye covered.',
                            'assets/images/vision_testing/instructions_icons/left-eye.png'),
                        buildPageViewBlock(
                            'Step 6.',
                            'Take the Test',
                            'During this test you will see two blocks of two different colours and patterns within them. Tap on the box that appears clearer to you. If they both appear the same, tap on the arrow',
                            'assets/images/vision_testing/instructions_icons/icons8-smooth-background-color-100.png'),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Expanded(
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: _buildPageIndicator(),
                      ),
                    ),
                  ),
                  // SizedBox(
                  //   height: MediaQuery.of(context).size.height * 0.15,
                  // ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        FlatButton(
                            onPressed: () {
                              _currentPage != 0
                                  ? _pageController.previousPage(
                                      duration: Duration(milliseconds: 500),
                                      curve: Curves.ease)
                                  : Navigator.popAndPushNamed(
                                  context, VisionTestingMain.id);
                            },
                            child: Icon(
                              _currentPage != 0
                              ?  Icons.arrow_back_ios_rounded
                              : Icons.home_outlined,
                              size: 30,
                              color: kDarkTealColor,
                            )),
                        Text(
                            _currentPage != _numPages - 1
                                ? ''
                                : 'Start Test',
                            style: kBottomNavBarTextStyle.copyWith(color: kDarkTealColor)),
                        FlatButton(
                            onPressed: () {
                              _currentPage != _numPages - 1
                                  ? _pageController.nextPage(
                                      duration: Duration(milliseconds: 500),
                                      curve: Curves.ease)
                                  : Navigator.popAndPushNamed(
                                      context, DuochromeTestScreen.id);
                            },
                            child: Icon(
                              _currentPage != _numPages-1
                              ? Icons.arrow_forward_ios_rounded
                              : Icons.check,
                              size: 30,
                              color: kDarkTealColor
                            ))
                      ],
                    ),
                  )
                ],
              ),
            ),


            // child: Container(
            //   height: MediaQuery.of(context).size.height/2,
            //   color: Colors.deepOrange,
            //   child: Padding(
            //     padding: const EdgeInsets.only(top: 10.0),
            //     child: Column(
            //       crossAxisAlignment: CrossAxisAlignment.stretch,
            //       children: <Widget>[
            //         Container(
            //           alignment: Alignment.centerRight,
            //           child: FlatButton(
            //             onPressed: () {
            //               //TODO: push to testing screen
            //             },
            //             child: Text('Skip', style: kBottomNavBarTextStyle),
            //           ),
            //         ),
            //         Expanded(
            //           child: Container(),
            //         ),
            //         Container(
            //           height: 300.0,
            //           child: PageView(
            //             physics: ClampingScrollPhysics(),
            //             controller: _pageController,
            //             onPageChanged: (int page) {
            //               setState(() {
            //                 _currentPage = page;
            //               });
            //             },
            //             children: <Widget>[
            //               buildPageViewBlock(
            //                   'Your\tOne-Stop\nEye\tCare\tSolution',
            //                   'Disease, Infection & Disorder Diagnosis coupled with fundus analysis, alongside services like medicine reminders and community.',
            //                   'assets/images/on_boarding/onBoarding1.png'),
            //               buildPageViewBlock(
            //                   'Artificially\nIntelligent\tPrognostics',
            //                   'Employing the finest Machine Learning and Artifical Intelligence techniques for accurate and reliable diagnosis.',
            //                   'assets/images/on_boarding/onBoarding2.png'),
            //               buildPageViewBlock(
            //                   'Eye\tCare\nIn\tYour\tHands',
            //                   'A doctor in your hands, and at your home, costing nothing but a few taps on the screen.',
            //                   'assets/images/on_boarding/onBoarding3.png'),
            //             ],
            //           ),
            //         ),
            //         Row(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           children: _buildPageIndicator(),
            //         ),
            //         SizedBox(
            //           height: MediaQuery.of(context).size.height * 0.15,
            //         ),
            //         Expanded(
            //             child: Align(
            //               alignment: FractionalOffset.bottomRight,
            //               child: FlatButton(
            //                 onPressed: () {
            //                   _currentPage != _numPages - 1
            //                       ? _pageController.nextPage(
            //                       duration: Duration(milliseconds: 500),
            //                       curve: Curves.ease)
            //                       : Navigator.popAndPushNamed(context, LoginScreen.id);
            //                 },
            //                 child: Padding(
            //                   padding: const EdgeInsets.only(bottom: 10.0),
            //                   child: Row(
            //                     mainAxisAlignment: MainAxisAlignment.center,
            //                     mainAxisSize: MainAxisSize.min,
            //                     children: [
            //                       Padding(
            //                         padding: const EdgeInsets.only(top: 5.0),
            //                         child: Text(
            //                             _currentPage != _numPages - 1
            //                                 ? 'Next'
            //                                 : 'Get Started',
            //                             style: kBottomNavBarTextStyle),
            //                       ),
            //                       SizedBox(
            //                         width: 10.0,
            //                       ),
            //                       Icon(
            //                         Icons.arrow_forward_ios,
            //                         color: kTealColor,
            //                         size: 30.0,
            //                       )
            //                     ],
            //                   ),
            //                 ),
            //               ),
            //             )),
            //       ],
            //     ),
            //   ),
            // ),
          ),
        ),
      ),
    );
  }

  Widget buildPageViewBlock(String StepText, String mainText, String subText, String image) {
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20, bottom: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Container(
              alignment: Alignment.center,
              height: 100,
              width: 300,
              child: FittedBox(
                child: Image(
                  image: AssetImage(image),
                  color: kDarkTealColor,
                ),
                fit: BoxFit.contain,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          // Center(
          //   child: Container(
          //     height: 2.0,
          //     width: 300.0,
          //     color: kAmberColor,
          //   ),
          // ),

          Text(
            StepText,
            style: kOnBoardingTitleStyle.copyWith(
                fontSize: 28, color: kAmberColor),
          ),
          Text(
            mainText,
            style: kOnBoardingTitleStyle.copyWith(
                fontSize: 24, color: kDarkTealColor),
          ),
          SizedBox(
            height: 15.0,
          ),
          Text(
            subText,
            style: kOnBoardingSubtitleStyle.copyWith(
                fontSize: 20, color: kDarkTealColor),
          ),
        ],
      ),
    );
  }
}
