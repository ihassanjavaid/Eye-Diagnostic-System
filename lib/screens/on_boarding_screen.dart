import 'package:eye_diagnostic_system/screens/login_screen.dart';
import 'package:eye_diagnostic_system/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

class OnBoardingScreen extends StatefulWidget {
  static const String id = 'on_boarding_screen';

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final int _numPages = 3;
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
        child: Container(
          color: kScaffoldBackgroundColor,
          child: Padding(
            padding: const EdgeInsets.only(top: 40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  alignment: Alignment.centerRight,
                  child: FlatButton(
                    onPressed: () {
                      Navigator.popAndPushNamed(context, LoginScreen.id);
                    },
                    child: Text('Skip', style: kBottomNavBarTextStyle),
                  ),
                ),
                Expanded(
                  child: Container(),
                ),
                Container(
                  height: 460.0,
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
                          'Your\tOne-Stop\nEye\tCare\tSolution',
                          'Disease, Infection & Disorder Diagnosis coupled with fundus analysis, alongside services like medicine reminders and community.',
                          'assets/images/on_boarding/onBoarding1.png'),
                      buildPageViewBlock(
                          'Artificially\nIntelligent\tPrognostics',
                          'Employing the finest Machine Learning and Artifical Intelligence techniques for accurate and reliable diagnosis.',
                          'assets/images/on_boarding/onBoarding2.png'),
                      buildPageViewBlock(
                          'Eye\tCare\nIn\tYour\tHands',
                          'A doctor in your hands, and at your home, costing nothing but a few taps on the screen.',
                          'assets/images/on_boarding/onBoarding3.png'),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildPageIndicator(),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.15,
                ),
                Expanded(
                    child: Align(
                  alignment: FractionalOffset.bottomRight,
                  child: FlatButton(
                    onPressed: () {
                      _currentPage != _numPages - 1
                          ? _pageController.nextPage(
                              duration: Duration(milliseconds: 500),
                              curve: Curves.ease)
                          : Navigator.popAndPushNamed(context, LoginScreen.id);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: Text(
                                _currentPage != _numPages - 1
                                    ? 'Next'
                                    : 'Get Started',
                                style: kBottomNavBarTextStyle),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: kTealColor,
                            size: 30.0,
                          )
                        ],
                      ),
                    ),
                  ),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildPageViewBlock(String mainText, String subText, String image) {
    return Padding(
      padding: EdgeInsets.all(40.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              height: 130,
              width: 130,
              child: FittedBox(
                child: Image.asset(image),
                fit: BoxFit.contain,
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Center(
            child: Container(
              height: 2.0,
              width: 300.0,
              color: kAmberColor,
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
          Text(
            mainText,
            style: kOnBoardingTitleStyle,
          ),
          SizedBox(
            height: 15.0,
          ),
          Text(
            subText,
            style: kOnBoardingSubtitleStyle,
          ),
        ],
      ),
    );
  }
}
