import 'package:eye_diagnostic_system/components/header_clipper_component.dart';
import 'package:eye_diagnostic_system/services/greetings_service.dart';
import 'package:eye_diagnostic_system/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:eye_diagnostic_system/models/chart_data.dart';
import 'dart:math' as Math;

class ReportingScreen extends StatefulWidget {
  static const String id = 'reporting_screen';

  final text;
  final percentage;

  const ReportingScreen({Key key, this.text, this.percentage}) : super(key: key);

  @override
  _ReportingScreenState createState() => _ReportingScreenState();
}

class _ReportingScreenState extends State<ReportingScreen> {
  /*List<ChartData> chartData = [
    getDiseaseValue(widget.percentage),
  ];*/

  List<ChartData> getChartData() {
    List<ChartData> chartData = [
      getDiseaseValue(widget.percentage),
      getExtraValue(widget.percentage)
    ];
    return chartData;
  }

  /*List<Color> chartPalette = [
    kNoDiseaseIndicatorColor,
    *//*kMildestDiseaseIndicatorColor,
    kMildDiseaseIndicatorColor,
    kDiseaseIndicationColor*//*
  ];*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kScaffoldBackgroundColor,
      body: Container(
        color: kScaffoldBackgroundColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                            text: 'Reports',
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
              padding: const EdgeInsets.only(left: 20.0, top: 12.0),
              child: FutureBuilder(
                future: _getUserName(),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
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
            Padding(
              padding: const EdgeInsets.only(left: 20.0, top: 32.0),
              child: FutureBuilder(
                future: _getResults(),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  return RichText(
                      text: TextSpan(children: [
                    TextSpan(
                      text: 'EyeSee\'s results show that,\n',
                      style: kDashboardSubtitleTextStyle.copyWith(
                          color: kTealColor),
                    ),
                    TextSpan(
                      text: 'you have\t',
                      style: kDashboardSubtitleTextStyle.copyWith(
                          color: kTealColor),
                    ),
                    TextSpan(
                      text: '${widget.text}',
                      style: kDashboardSubtitleTextStyle.copyWith(
                          color: kDiseaseIndicationColor),
                    ),
                  ]));
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, top: 32.0),
              child: Text(
                'Statistics:',
                style: kDashboardSubtitleTextStyle.copyWith(color: kTealColor),
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                //crossAxisAlignment: CrossAxisAlignment,
                children: [
                  Container(
                    /*child: SfCircularChart(
                      palette: chartPalette,
                        series: <CircularSeries>[
                          RadialBarSeries<ChartData, String>(
                              dataSource: chartData,
                              xValueMapper: (ChartData data, _) => data.x,
                              yValueMapper: (ChartData data, _) => data.y,
                              // Corner style of radial bar segment
                              cornerStyle: CornerStyle.bothCurve
                          )
                        ]
                    ),*/
                    height: MediaQuery.of(context).size.height/3 - 10,
                    width: MediaQuery.of(context).size.height/3 - 10,
                    child: SfCircularChart(
                      annotations: <CircularChartAnnotation>[
                        CircularChartAnnotation(
                            widget: Container(
                                child: Text(
    '${roundOff(widget.percentage)}%',
                                    style: kDashboardSubtitleTextStyle.copyWith(
                                        color: kDiseaseIndicationColor,
                                    fontSize: 36))))
                      ],
                      series: <CircularSeries>[
                        DoughnutSeries<ChartData, String>(
                            innerRadius: '78%',
                            dataSource: getChartData(),
                            pointColorMapper:(ChartData data,  _) => data.color,
                            xValueMapper: (ChartData data, _) => data.x,
                            yValueMapper: (ChartData data, _) => data.y,
                        )
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.circle,
                            size: 16,
                            color: kDiseaseIndicationColor,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 4.0, left: 5.0),
                            child: Text(
                              '${widget.text}',
                              style: kChartStatsTextStyle.copyWith(color: kDiseaseIndicationColor),
                            ),
                          )
                        ],
                      ),
                      /*Row(
                        children: [
                          Icon(
                            Icons.circle,
                            size: 16,
                            color: kMildDiseaseIndicatorColor,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 4.0, left: 5.0),
                            child: Text(
                              'Glaucoma',
                              style: kChartStatsTextStyle,
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.circle,
                            size: 16,
                            color: kMildestDiseaseIndicatorColor,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 4.0, left: 5.0),
                            child: Text(
                              'Diabetes',
                              style: kChartStatsTextStyle,
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.circle,
                            size: 16,
                            color: kNoDiseaseIndicatorColor,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 4.0, left: 5.0),
                            child: Text(
                              'Misc.',
                              style: kChartStatsTextStyle,
                            ),
                          )
                        ],
                      )*/
                    ],
                  )
                ],
              ),
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
                          /// TODO : implement
                        },
                        child: Icon(
                          Icons.delete,
                          color: kTealColor,
                          size: 42.0,
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        'Delete Report',
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
                          /// TODO : Implement
                        },
                        child: Icon(
                          Icons.download_rounded,
                          color: kTealColor,
                          size: 42.0,
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        'Download PDF',
                        style: kDashboardButtonLabelStyle,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
          ],
        ),
      ),
    );
  }

  Future<String> _getResults() async {
    /// TODO : implement
    String _name = '';
    return _name;
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

  roundOff(String perc) {
    return perc.substring(0, perc.indexOf('.'));
  }

  getDiseaseValue(String perc){
    double percentage = double.parse(perc.substring(0, perc.indexOf('.')));
    return ChartData('1', percentage, kDiseaseIndicationColor);
  }

  getExtraValue(String perc){
    double percentage = double.parse(perc.substring(0, perc.indexOf('.')));
    return ChartData('1', (100 - percentage), kGreyButtonColor);
  }
}
