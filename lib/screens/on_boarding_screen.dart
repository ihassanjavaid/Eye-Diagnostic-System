import 'dart:async';

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
  Timer _timer;
  double _circleWidth = 3.5;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for ( int i = 0 ; i < _numPages ; i++ ){
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
        color: isActive ? kGoldenColor : Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  _animateCircle(){
    setState(() {
      _circleWidth = _circleWidth == 10.0 ? 0.1 : 10.0;
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
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.1, 0.4, 0.7, 0.9],
              colors: kBgColorGradientArrayBlues,
            ),
          ),
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
                    child: Text(
                      'Skip',
                      style: kBottomNavBarTextStyle
                    ),
                  ),
                ),
                Container(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Image(
                        image: AssetImage(
                            'assets/images/eye_noball.png'
                        ),
                        height: 220,
                        width: 220,
                      ),
                      _buildAnimatedContainer(),
                    ],
                  ),
                ),
                Center(
                    child: Container(
                      height: 2.0,
                      width: 300.0,
                      color: kGoldenColor,
                    ),
                ),
                Container(
                  height: 310.0,
                  child: PageView(
                    physics: ClampingScrollPhysics(),
                    controller: _pageController,
                    onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                    children: <Widget>[
                      buildTextBlock(
                          'World Class\ndiagnosis',
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean dapibus auctor sem pretium pellentesque.',
                      ),
                      buildTextBlock(
                        'Military grade\ntesting standards',
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean dapibus auctor sem pretium pellentesque.',
                      ),
                      buildTextBlock(
                        'All your solutions\nin one place',
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean dapibus auctor sem pretium pellentesque.',
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildPageIndicator(),
                ),
                Expanded(
                    child: Align(
                      alignment: FractionalOffset.bottomRight,
                      child: FlatButton(
                        onPressed: () {
                          _currentPage != _numPages -1 ?
                          _pageController.nextPage(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.ease
                          ) :
                          Navigator.popAndPushNamed(context, LoginScreen.id);
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
                                  _currentPage != _numPages -1 ?
                                  'Next' : 'Get Started',
                                  style: kBottomNavBarTextStyle
                                ),
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.white,
                                size: 30.0,
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedContainer() {
    return Container(
                height: 52,
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 2000),
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: kPurpleColor.withOpacity(0.8),
                  ),
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 2000),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.transparent,
                      border: Border.all(
                        color: kGoldenColor,
                        width: _circleWidth,
                      ),
                    ),
                  ),
                ),
              );
  }

  Widget buildTextBlock(String mainText, String subText) {
    return Padding(
                      padding: EdgeInsets.all(40.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 10.0,
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
