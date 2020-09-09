import 'package:eye_diagnostic_system/components/header_clipper_component.dart';
import 'package:eye_diagnostic_system/utilities/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReminderMain extends StatefulWidget {
  static const String id = 'reminder_main_screen';

  @override
  _ReminderMainState createState() => _ReminderMainState();
}

class _ReminderMainState extends State<ReminderMain> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
        },
        child: Icon(
         Icons.add
        ),
        backgroundColor: kTealColor,
      ),
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
                            text: 'Souvenir',
                            style: kDashboardTitleTextStyle.copyWith(
                                color: kAmberColor),
                          ),
                        ]),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(bottom: 10),
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: '2 due\t\t',
                              style: kDashboardTitleTextStyle.copyWith(fontSize: 20.0),
                            ),
                            TextSpan(
                              text: '|',
                              style:  kDashboardTitleTextStyle.copyWith(fontSize: 20.0, color: kAmberColor, fontFamily: '', fontWeight: FontWeight.w900),
                            ),
                            TextSpan(
                              text: '\t\t1 in total',
                              style: kDashboardTitleTextStyle.copyWith(fontSize: 20.0),
                            ),
                          ]
                        ),
                      )
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(

              ),
            ),
          ],
        ),
      ),
    );
  }

}
