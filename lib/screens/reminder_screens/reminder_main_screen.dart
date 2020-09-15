import 'package:eye_diagnostic_system/components/header_clipper_component.dart';
import 'package:eye_diagnostic_system/models/provider_data.dart';
import 'package:eye_diagnostic_system/services/firestore_reminder_services.dart';
import 'package:eye_diagnostic_system/utilities/constants.dart';
import 'package:eye_diagnostic_system/widgets/alert_widget.dart';
import 'package:eye_diagnostic_system/widgets/speed_dial_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class ReminderMain extends StatefulWidget {
  static const String id = 'reminder_main_screen';

  @override
  _ReminderMainState createState() => _ReminderMainState();
}

class _ReminderMainState extends State<ReminderMain> {
  FirestoreReminderService _firestoreReminderService =
      FirestoreReminderService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SpeedDialWidget().speedDialReminder(context),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: kScaffoldBackgroundColor,
        child: Column(
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
                            text: 'Journal',
                            style: kDashboardTitleTextStyle.copyWith(
                                color: kAmberColor),
                          ),
                          // This Text-Span in only for Provider in order to setState() when required.
                          TextSpan(
                            text: '${Provider.of<ProviderData>(context).modelString}',
                            style: kDashboardTitleTextStyle.copyWith(
                                color: kAmberColor),
                          ),
                        ]),
                      ),
                    ),
                    Container(
                      child: FutureBuilder(
                        future: _firestoreReminderService.getTotalRemindersCount(),
                        builder: (BuildContext context,
                            AsyncSnapshot<dynamic> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Text(
                              'Loading...',
                              style: kDashboardTitleTextStyle.copyWith(fontSize: 20.0),
                            );
                          } else {
                            return Text(
                              snapshot.data.toString(),
                              style: kDashboardTitleTextStyle.copyWith(fontSize: 20.0),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'One Time Reminders',
                      style: kDashboardSubtitleTextStyle.copyWith(
                          color: kAmberColor),
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.33,
                  width: double.infinity,
                  child: FutureBuilder(
                    future: _firestoreReminderService.getOneTimeReminders(),
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
                                        snapshot.data[index].data()['title'],
                                        style: kReminderMainTextStyle,
                                      ),
                                      subtitle: Text(
                                          '${snapshot.data[index].data()['actualTime']}\t-\t'
                                          '${snapshot.data[index].data()['actualDate']}',
                                          style: kReminderSubtitleTextStyle
                                      ),
                                      trailing: IconButton(
                                        icon: Icon(
                                          FontAwesomeIcons.ellipsisV,
                                          size: 20.0,
                                          color: kTealColor,
                                        ),
                                        onPressed: () {
                                          AlertWidget().generateReminderDelete(
                                              context: context,
                                              title: '${snapshot.data[index].data()['title']}').show();
                                        },
                                      ),
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
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, top: 30.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Medicine Schedules',
                      style: kDashboardSubtitleTextStyle.copyWith(
                          color: kAmberColor),
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.33,
                  width: double.infinity,
                  child: FutureBuilder(
                    future: _firestoreReminderService.getRecurringReminders(),
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
                                        snapshot.data[index].data()['title'],
                                        style: kReminderMainTextStyle,
                                      ),
                                      subtitle: Text(
                                          '${snapshot.data[index].data()['recurrence']}\ttimes a day\t-\t'
                                          'Till\t${snapshot.data[index].data()['actualDate']}',
                                          style: kReminderSubtitleTextStyle
                                      ),
                                      trailing: IconButton(
                                        icon: Icon(
                                          FontAwesomeIcons.ellipsisV,
                                          size: 20.0,
                                          color: kTealColor,
                                        ),
                                        onPressed: () {
                                          AlertWidget().generateReminderDelete(
                                              context: context,
                                              title: '${snapshot.data[index].data()['title']}').show();
                                        },
                                      ),
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
