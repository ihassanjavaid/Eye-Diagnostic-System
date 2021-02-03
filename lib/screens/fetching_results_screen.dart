import 'package:eye_diagnostic_system/components/header_clipper_component.dart';
import 'package:eye_diagnostic_system/widgets/fading_icon.dart';
import 'package:flutter/material.dart';
import 'package:eye_diagnostic_system/utilities/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class FetchingResultsScreen extends StatefulWidget {
  static const String id = 'fetching_results_screen';

  @override
  _FetchingResultsScreenState createState() => _FetchingResultsScreenState();
}

class _FetchingResultsScreenState extends State<FetchingResultsScreen> {
  bool isActive = true;
  String _text = '';

  Widget towerIconMain = Text('');
  Widget cogsIconMain = Text('');
  Widget outIconMain = Text('');

  Widget towerIconInitial = Icon(
    FontAwesomeIcons.broadcastTower,
    color: Colors.grey[400],
    size: 60,
  );
  Widget towerIconLoading = CustomFadingIcon(FontAwesomeIcons.broadcastTower);
  Widget towerIconDone = Icon(
    FontAwesomeIcons.broadcastTower,
    color: kTealColor,
    size: 60,
  );

  Widget cogsIconInitial = Icon(
    FontAwesomeIcons.cogs,
    color: Colors.grey[400],
    size: 60,
  );
  Widget cogsIconLoading = CustomFadingIcon(FontAwesomeIcons.cogs);
  Widget cogsIconDone = Icon(
    FontAwesomeIcons.cogs,
    color: kTealColor,
    size: 60,
  );

  Widget outIconInitial = Icon(
    FontAwesomeIcons.signOutAlt,
    color: Colors.grey[400],
    size: 60,
  );
  Widget outIconLoading = CustomFadingIcon(FontAwesomeIcons.signOutAlt);
  Widget outIconDone = Icon(
    FontAwesomeIcons.signOutAlt,
    color: kTealColor,
    size: 60,
  );

  @override
  void initState() {
    super.initState();
    _text = 'Connecting to Server...';
    towerIconMain = towerIconInitial;
    cogsIconMain = cogsIconInitial;
    outIconMain = outIconInitial;
    handleAnimationPath();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kScaffoldBackgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          text: 'Diagnostics',
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
          Center(
            child: Container(
              height: size.height / 3 + 100,
              width: size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      towerIconMain,
                      cogsIconMain,
                      outIconMain,
                    ],
                  ),
                  SizedBox(
                    height: size.height / 6,
                  ),
                  Text(
                    _text,
                    style: kBottomNavBarTextStyle,
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: size.height / 10,
          )
        ],
      ),
    );
  }

  handleAnimationPath() async {
    await handleTowerIcon();
    setState(() {
      _text = 'Calculating Results...';
    });
    await handleCogsIcon();
    setState(() {
      _text = 'Compiling Report...';
    });
    await handleOutIcon();
    setState(() {
      _text = 'Done!';
    });
  }

  handleTowerIcon() async {
    await Future.delayed(const Duration(milliseconds: 10), (){
      setState(() {
        towerIconMain = towerIconLoading;
      });
    });
    await Future.delayed(const Duration(seconds: 2), (){
      setState(() {
        towerIconMain = towerIconDone;
      });
    });
  }

  handleCogsIcon() async {
    await Future.delayed(const Duration(milliseconds: 10), (){
      setState(() {
        cogsIconMain = cogsIconLoading;
      });
    });
    await Future.delayed(const Duration(seconds: 8), (){
      setState(() {
        cogsIconMain = cogsIconDone;
      });
    });
  }

  handleOutIcon() async {
    await Future.delayed(const Duration(milliseconds: 10), (){
      setState(() {
        outIconMain = outIconLoading;
      });
    });
    await Future.delayed(const Duration(seconds: 2), (){
      setState(() {
        outIconMain = outIconDone;
      });
    });
  }

}

/*Icon(
  FontAwesomeIcons.broadcastTower,
  color: kTealColor,
  size: 60,
),
Icon(
  FontAwesomeIcons.cogs,
  color: kTealColor,
  size: 60,
),
Icon(
  FontAwesomeIcons.signOutAlt,
  color: kTealColor,
  size: 60,
),*/