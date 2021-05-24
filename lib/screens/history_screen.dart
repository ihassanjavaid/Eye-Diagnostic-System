import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eye_diagnostic_system/components/header_clipper_component.dart';
import 'package:eye_diagnostic_system/utilities/constants.dart';
import 'package:eye_diagnostic_system/widgets/alert_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:eye_diagnostic_system/services/firestore_history_service.dart';

class HistoryScreen extends StatefulWidget {
  static const String id = 'history_screen';

  const HistoryScreen({Key key}) : super(key: key);

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  FirestoreHistoryService _firestoreHistoryService = FirestoreHistoryService();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        color: kScaffoldBackgroundColor,
        child: Column(
          children: <Widget>[
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
                            text: 'My\t',
                            style: kDashboardTitleTextStyle.copyWith(
                                color: kAmberColor),
                          ),
                          TextSpan(
                            text: 'Diagnosis\tHistory',
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
            Flexible(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.75,
                width: double.infinity,
                child: FutureBuilder(
                  future: _firestoreHistoryService.getHistory(),
                  builder: (BuildContext context,
                      AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(
                          backgroundColor: kTealColor,
                        ),
                      );
                    } else {
                      return Container(
                        height: 200,
                        width: double.maxFinite,
                        child: ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  ListTile(
                                    leading: Padding(
                                      padding:
                                      const EdgeInsets.only(top: 6.0),
                                      child: CircleAvatar(
                                        maxRadius: 15,
                                        backgroundColor: kTealColor,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 4.0, left: 1.0),
                                          child: Text((index + 1).toString(),
                                              style:
                                              kReminderBulletsTextStyle),
                                        ),
                                      ),
                                    ),
                                    title: Text(
                                      '${snapshot.data[index].data()['text']}, ${snapshot.data[index].data()['percentage']}%',
                                      style: kReminderMainTextStyle,
                                    ),
                                    subtitle: Text(
                                        snapshot.data[index].data()['date'],
                                        style: kReminderSubtitleTextStyle),
                                    // trailing: IconButton(
                                    //   icon: Icon(
                                    //     FontAwesomeIcons.ellipsisV,
                                    //     size: 20.0,
                                    //     color: kTealColor,
                                    //   ),
                                    //   onPressed: () {
                                    //   },
                                    // ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15.0),
                                    child: Container(
                                      height: 2.0,
                                      width: double.infinity,
                                      color: kTealColor.withOpacity(0.5),
                                    ),
                                  )
                                ],
                              );
                            }),
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
