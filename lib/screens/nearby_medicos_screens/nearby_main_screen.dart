import 'package:eye_diagnostic_system/screens/nearby_medicos_screens/nearby_medicos_screen.dart';
import 'package:eye_diagnostic_system/screens/nearby_medicos_screens/nearby_optometrists_screen.dart';
import 'package:eye_diagnostic_system/utilities/constants.dart';
import 'package:flutter/material.dart';

class NearbyMain extends StatefulWidget {
  static const String id = 'nearby_main_screen';

  @override
  _NearbyMainState createState() => _NearbyMainState();
}

class _NearbyMainState extends State<NearbyMain> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            color: kScaffoldBackgroundColor
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Container(
                  alignment: Alignment.center,
                  child: RichText(
                    text: TextSpan(children: [
                      TextSpan(
                        text: 'EyeSee\t',
                        style: kDashboardTitleTextStyle.copyWith(
                            color: kTealColor),
                      ),
                      TextSpan(
                        text: 'Radar',
                        style: kDashboardTitleTextStyle.copyWith(
                            color: kTealColor),
                      ),
                    ]),
                  ),
                ),
              ),
              Container(
                color: Colors.transparent,
                height: 60,
                width: double.infinity,
                child: TabBar(
                  indicatorWeight: 4.0,
                  indicatorColor: kTealColor.withOpacity(0.8),
                  tabs: [
                    Tab(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.remove_red_eye,
                            color: kTealColor,
                          ),
                          SizedBox(
                            width: 12.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: Text(
                              'Opticians',
                              style: kBottomNavBarTextStyle.copyWith(
                                  color: kTealColor,
                                  fontSize: 19.5),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Tab(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.medical_services_rounded,
                              color: kTealColor
                          ),
                          SizedBox(
                            width: 12.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: Text(
                              'Medicos',
                              style: kBottomNavBarTextStyle.copyWith(
                                  color: kTealColor,
                                  fontSize: 19.5),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(
                child: TabBarView(
                  children: [
                    NearbyOptometrists(),
                    NearbyMedicos(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
