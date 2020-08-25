import 'package:eye_diagnostic_system/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {

  final int _numPages = 3;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

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
        color: isActive ? Colors.white : Color(0xFF7B51D3),
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
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.1, 0.4, 0.7, 0.9],
              colors: kBgColorGradientArray,
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
                    onPressed: () { print('### skip button pressed'); },
                    child: Text(
                      'Skip',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 600.0,
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
                          AssetImage(
                              'assets/images/eye_1.png'
                          ),
                      ),
                      buildTextBlock(
                        'Military grade\ntesting standards',
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean dapibus auctor sem pretium pellentesque.',
                          AssetImage(
                              'assets/images/eye_2.png'
                          )
                      ),
                      buildTextBlock(
                        'All your solutions\nin one place',
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean dapibus auctor sem pretium pellentesque.',
                          AssetImage(
                              'assets/images/eye_3.png'
                          )
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildPageIndicator(),
                ),
                _currentPage != _numPages -1
                    ? Expanded(
                    child: Align(
                      alignment: FractionalOffset.bottomRight,
                      child: FlatButton(
                        onPressed: () {
                          _pageController.nextPage(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.ease
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Next',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22.0
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
                )
                    : Text('')
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: _currentPage == _numPages -1
      ? Container(
        height: 50.0,
        width: double.infinity,
        color: Color(0xFF5B16D0),
        child: GestureDetector(
          onTap: () {
            print('### Get Started');
          },
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                'Get Started',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
          ),
        ),
      )
      : Container(
        height: 1.0,
        color: Color(0xFF5B16D0),
      ),
    );
  }

  Widget buildTextBlock(String mainText, String subText, AssetImage image) {
    return Padding(
                      padding: EdgeInsets.all(40.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Image(
                              image: image,
                              height: 220.0,
                              width: 220.0,
                            ),
                          ),
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
