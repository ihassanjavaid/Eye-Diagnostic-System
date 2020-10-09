import 'dart:async';
import 'package:eye_diagnostic_system/components/dashboard_card_clipper.dart';
import 'package:eye_diagnostic_system/screens/diagnosis_screen.dart';
import 'package:eye_diagnostic_system/screens/nearby_medicos_screens/nearby_main_screen.dart';
import 'package:eye_diagnostic_system/screens/vision_testing_screens/vision_testing_main.dart';
import 'package:eye_diagnostic_system/services/greetings_service.dart';
import 'package:eye_diagnostic_system/utilities/eye_facts_utility.dart';
import 'package:eye_diagnostic_system/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'assistant_screens/assistant_chatbot_screen.dart';
import 'extras_screen.dart';

class Dashboard extends StatefulWidget {
  static const String id = 'main_dashboard_screen';

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final int _numPages = 3;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  Timer _timer;
  double _circleWidth = 3.5;
  /// TODO eye facts
  EyeFacts _eyeFacts = EyeFacts();
  // print(await _eyeFacts.getFact());

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
                Center(
                  child: RichText(
                    text: TextSpan(children: [
                      TextSpan(
                        text: 'Eye\t',
                        style: kDashboardTitleTextStyle.copyWith(
                            color: kTealColor),
                      ),
                      TextSpan(
                        text: 'See',
                        style: kDashboardTitleTextStyle.copyWith(
                            color: kTealColor),
                      ),
                    ]),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, top: 12.0),
                  child: FutureBuilder(
                    future: _getUserName(),
                    builder: (BuildContext context,
                        AsyncSnapshot<dynamic> snapshot) {
                      return RichText(
                          text: TextSpan(children: [
                        TextSpan(
                          text: '${Greetings.showGreetings()},\t',
                          style: kDashboardSubtitleTextStyle.copyWith(
                              color: kTealColor),
                        ),
                        TextSpan(
                          text: '${snapshot.data}!',
                          style: kDashboardSubtitleTextStyle.copyWith(
                              color: kAmberColor),
                        ),
                      ]));
                    },
                  ),
                ),
                Container(
                  height: 384.0,
                  child: PageView(
                    physics: ClampingScrollPhysics(),
                    controller: _pageController,
                    onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, VisionTestingMain.id);
                        },
                        child: _buildMainDashboardContainer('Eye\nSight Test',
                            'assets/images/svgs/eye_sight.svg'),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, DiagnosisScreen.id);
                        },
                        child: _buildMainDashboardContainer(
                            'EyeSee\nDiagnostics', ''),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, NearbyMain.id);
                        },
                        child: _buildMainDashboardContainer(
                            'Nearby\nOptometrists',
                            'assets/images/svgs/google_maps.svg'),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildPageIndicator(),
                ),
                SizedBox(
                  height: 40.0,
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
                              //Navigator.pushNamed(context, Extras.id);
                              Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                      transitionDuration: Duration(seconds: 2),
                                      pageBuilder: (_, __, ___) => Extras()));
                            },
                            child: Hero(
                              tag: 'extras',
                              child: Icon(
                                Icons.person,
                                color: kTealColor,
                                size: 42.0,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            'My EyeSee',
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
                              Navigator.pushNamed(context, Assistant.id);
                            },
                            child: Icon(
                              Icons.mic,
                              color: kTealColor,
                              size: 42.0,
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            'Assistant',
                            style: kDashboardButtonLabelStyle,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMainDashboardContainer(String title, String image) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      child: Container(
        decoration: BoxDecoration(
          color: kAmberColor.withOpacity(0.7),
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
        ),
        child: Stack(
          children: [
            ClipPath(
              clipper: DashboardCardCustomClipper(),
              child: Container(
                width: double.infinity,
                height: 300,
                decoration: BoxDecoration(
                 color: kTealColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12.0),
                      topRight: Radius.circular(12.0),
                      bottomLeft: Radius.circular(12.0)),
                ),
                /// TODO put image here
                /*child: SvgPicture.asset(
                  image,
                ),*/
              ),
            ),
            Positioned(
              bottom: 18.0,
              left: 20.0,
              child: Text(
                title,
                style: kDashboardTitleTextStyle.copyWith(color: kTealColor),
              ),
            ),
          ],
        ),
      ),
    );
  }

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

  Future<String> _getUserName() async {
    String _name;
    final SharedPreferences pref = await SharedPreferences.getInstance();
    _name = pref.getString('displayName');
    // to display only first name
    if (_name.contains(' ')) {
      _name = _name.substring(0, _name.indexOf(' '));
    }
    return _name;
  }
}
