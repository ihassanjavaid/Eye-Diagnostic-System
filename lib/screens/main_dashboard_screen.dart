import 'dart:async';
import 'package:eye_diagnostic_system/components/dashboard_card_clipper.dart';
import 'package:eye_diagnostic_system/screens/assistant_screen.dart';
import 'package:eye_diagnostic_system/screens/login_screen.dart';
import 'package:eye_diagnostic_system/screens/nearby_medicos_screens/nearby_main_screen.dart';
import 'package:eye_diagnostic_system/services/auth_service.dart';
import 'package:eye_diagnostic_system/services/greetings_service.dart';
import 'package:eye_diagnostic_system/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'assistant_screen.dart';
import 'extras_screen.dart';

class Dashboard extends StatefulWidget {
  static const String id = 'main_dashboard_screen';

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  Auth _auth = Auth();
  final int _numPages = 4;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  Timer _timer;
  double _circleWidth = 3.5;

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
        color: isActive ? kGoldenColor : Colors.white,
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
                            color: kPurpleColor),
                      ),
                      TextSpan(
                        text: 'See',
                        style: kDashboardTitleTextStyle.copyWith(
                            color: kGoldenColor),
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
                              color: kPurpleColor),
                        ),
                        TextSpan(
                          text: '${snapshot.data}!',
                          style: kDashboardSubtitleTextStyle.copyWith(
                              color: kGoldenColor),
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
                        onTap: () {},
                        child: _buildMainDashboardContainer('Eye\nSight Test',
                            'assets/images/svgs/eye_sight.svg'),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: _buildMainDashboardContainer(
                            'Disease\nDiagnosis',
                            'assets/images/svgs/disease.svg'),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: _buildMainDashboardContainer(
                            'Fundus\nAnalysis', 'assets/images/svgs/fundo.svg'),
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
                                color: kGoldenColor,
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
                              color: kGoldenColor,
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
                Expanded(
                  child: Align(
                    alignment: FractionalOffset.bottomRight,
                    child: FlatButton(
                      onPressed: () {
                        _currentPage != _numPages - 1
                            ? _pageController.nextPage(
                                duration: Duration(milliseconds: 500),
                                curve: Curves.ease)
                            : Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()),
                              );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      /*floatingActionButton: ButtonWidget().speedDial(context),*/
    );
  }

  Widget _buildMainDashboardContainer(String title, String image) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.1, 0.5, 0.7, 0.9],
            colors: kBgColorGradientArrayBlues,
          ),
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
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.1, 0.4, 0.7, 0.9],
                    colors: kBgColorGradientArrayGreys,
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12.0),
                    topRight: Radius.circular(12.0),
                    bottomLeft: Radius.circular(12.0)
                  ),
                ),
                child: SvgPicture.asset(
                  image,
                ),
              ),
            ),
            Positioned(
              bottom: 18.0,
              left: 20.0,
              child: Text(
                title,
                style: kDashboardTitleTextStyle.copyWith(color: kGoldenColor),
              ),
            ),
            /*Positioned(
              bottom: 70.0,
              left: 50.0,
              child:
            ),*/
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedEyeBall() {
    return Container(
      height: 30.0,
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
