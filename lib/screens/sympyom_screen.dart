import 'package:eye_diagnostic_system/components/header_clipper_component.dart';
import 'package:eye_diagnostic_system/services/firestore_symptom_service.dart';
import 'package:eye_diagnostic_system/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class SymptomScreen extends StatefulWidget {
  static const String id = 'symptom_screen';

  const SymptomScreen({Key key}) : super(key: key);

  @override
  _SymptomScreenState createState() => _SymptomScreenState();
}

class _SymptomScreenState extends State<SymptomScreen> {
  FirestoreSymptomService _firestoreSymptomService = FirestoreSymptomService();
  bool _checkOne = false;
  bool _checkTwo = false;
  bool _checkThree = false;
  bool _checkFour = false;
  bool _checkFive = false;
  bool _checkSix = false;
  bool _checkSeven = false;

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
                            text: 'Enter\t',
                            style: kDashboardTitleTextStyle.copyWith(
                                color: kAmberColor),
                          ),
                          TextSpan(
                            text: 'Symptoms',
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
            FutureBuilder(
              future: _firestoreSymptomService.getSymptoms(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (!snapshot.hasData){
                  return Flexible(
                    child: Container(
                        height: MediaQuery.of(context).size.height * 0.75,
                        width: double.infinity,
                        child: Column(
                          children: [
                            //One
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'I have fever.',
                                    style: kReminderMainTextStyle,
                                  ),
                                  Transform.scale(
                                    scale: 1.2,
                                    child: Checkbox(
                                      value: _checkOne,
                                      checkColor: kAmberColor,
                                      activeColor: kTealColor,
                                      onChanged: (value) {
                                        setState(() {
                                          _checkOne = !_checkOne;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Two
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'I have blurry vision.',
                                    style: kReminderMainTextStyle,
                                  ),
                                  Transform.scale(
                                    scale: 1.2,
                                    child: Checkbox(
                                      value: _checkTwo,
                                      checkColor: kAmberColor,
                                      activeColor: kTealColor,
                                      onChanged: (value) {
                                        setState(() {
                                          _checkTwo = !_checkTwo;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Three
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'I have a migraine.',
                                    style: kReminderMainTextStyle,
                                  ),
                                  Transform.scale(
                                    scale: 1.2,
                                    child: Checkbox(
                                      value: _checkThree,
                                      checkColor: kAmberColor,
                                      activeColor: kTealColor,
                                      onChanged: (value) {
                                        setState(() {
                                          _checkThree = !_checkThree;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Four
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'I have bodily imbalance.',
                                    style: kReminderMainTextStyle,
                                  ),
                                  Transform.scale(
                                    scale: 1.2,
                                    child: Checkbox(
                                      value: _checkFour,
                                      checkColor: kAmberColor,
                                      activeColor: kTealColor,
                                      onChanged: (value) {
                                        setState(() {
                                          _checkFour = !_checkFour;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Five
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'I have light sensitivity.',
                                    style: kReminderMainTextStyle,
                                  ),
                                  Transform.scale(
                                    scale: 1.2,
                                    child: Checkbox(
                                      value: _checkFive,
                                      checkColor: kAmberColor,
                                      activeColor: kTealColor,
                                      onChanged: (value) {
                                        setState(() {
                                          _checkFive = !_checkFive;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Six
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'I have eye excretions.',
                                    style: kReminderMainTextStyle,
                                  ),
                                  Transform.scale(
                                    scale: 1.2,
                                    child: Checkbox(
                                      value: _checkSix,
                                      checkColor: kAmberColor,
                                      activeColor: kTealColor,
                                      onChanged: (value) {
                                        setState(() {
                                          _checkSix = !_checkSix;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Seven
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'I have red & itchy eyes.',
                                    style: kReminderMainTextStyle,
                                  ),
                                  Transform.scale(
                                    scale: 1.2,
                                    child: Checkbox(
                                      value: _checkSeven,
                                      checkColor: kAmberColor,
                                      activeColor: kTealColor,
                                      onChanged: (value) {
                                        setState(() {
                                          _checkSeven = !_checkSeven;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 10.0, right: 18.0, left: 18.0),
                              child: ButtonTheme(
                                minWidth: double.maxFinite,
                                height: 50,
                                child: RaisedButton(
                                  onPressed: () async {
                                    //Navigator.pop(context);
                                    List<bool> checks = [
                                      _checkOne,
                                      _checkTwo,
                                      _checkThree,
                                      _checkFour,
                                      _checkFive,
                                      _checkSix,
                                      _checkSeven
                                    ];
                                    await _firestoreSymptomService
                                        .setSymptoms(checks)
                                        .then((value) => {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Text(
                                          'Symptoms Saved',
                                          style:
                                          kReminderMainTextStyle.copyWith(
                                              color: kGreyButtonColor),
                                        ),
                                      ))
                                    });
                                  },
                                  color: kTealColor,
                                  focusColor: kAmberColor,
                                  autofocus: true,
                                  elevation: 10,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Icon(
                                        Icons.check,
                                        size: 26,
                                        color: kLightAmberColor,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Text(
                                          'Done',
                                          style: kDashboardButtonLabelStyle.copyWith(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w100,
                                              color: kLightAmberColor),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )),
                  );
                }
                else {
                  return Flexible(
                    child: Container(
                        height: MediaQuery.of(context).size.height * 0.75,
                        width: double.infinity,
                        child: Column(
                          children: [
                            //One
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'I have fever.',
                                    style: kReminderMainTextStyle,
                                  ),
                                  Transform.scale(
                                    scale: 1.2,
                                    child: Checkbox(
                                      value: snapshot.data.data()['one'],
                                      checkColor: kAmberColor,
                                      activeColor: kTealColor,
                                      onChanged: (value) {
                                        setState(() {
                                          _checkOne = !_checkOne;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Two
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'I have blurry vision.',
                                    style: kReminderMainTextStyle,
                                  ),
                                  Transform.scale(
                                    scale: 1.2,
                                    child: Checkbox(
                                      value: snapshot.data.data()['two'],
                                      checkColor: kAmberColor,
                                      activeColor: kTealColor,
                                      onChanged: (value) {
                                        setState(() {
                                          _checkTwo = !_checkTwo;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Three
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'I have a migraine.',
                                    style: kReminderMainTextStyle,
                                  ),
                                  Transform.scale(
                                    scale: 1.2,
                                    child: Checkbox(
                                      value: snapshot.data.data()['three'],
                                      checkColor: kAmberColor,
                                      activeColor: kTealColor,
                                      onChanged: (value) {
                                        setState(() {
                                          _checkThree = !_checkThree;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Four
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'I have bodily imbalance.',
                                    style: kReminderMainTextStyle,
                                  ),
                                  Transform.scale(
                                    scale: 1.2,
                                    child: Checkbox(
                                      value: snapshot.data.data()['four'],
                                      checkColor: kAmberColor,
                                      activeColor: kTealColor,
                                      onChanged: (value) {
                                        setState(() {
                                          _checkFour = !_checkFour;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Five
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'I have light sensitivity.',
                                    style: kReminderMainTextStyle,
                                  ),
                                  Transform.scale(
                                    scale: 1.2,
                                    child: Checkbox(
                                      value: snapshot.data.data()['five'],
                                      checkColor: kAmberColor,
                                      activeColor: kTealColor,
                                      onChanged: (value) {
                                        setState(() {
                                          _checkFive = !_checkFive;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Six
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'I have eye excretions.',
                                    style: kReminderMainTextStyle,
                                  ),
                                  Transform.scale(
                                    scale: 1.2,
                                    child: Checkbox(
                                      value: snapshot.data.data()['six'],
                                      checkColor: kAmberColor,
                                      activeColor: kTealColor,
                                      onChanged: (value) {
                                        setState(() {
                                          _checkSix = !_checkSix;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Seven
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'I have red & itchy eyes.',
                                    style: kReminderMainTextStyle,
                                  ),
                                  Transform.scale(
                                    scale: 1.2,
                                    child: Checkbox(
                                      value: snapshot.data.data()['seven'],
                                      checkColor: kAmberColor,
                                      activeColor: kTealColor,
                                      onChanged: (value) {
                                        setState(() {
                                          _checkSeven = !_checkSeven;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 10.0, right: 18.0, left: 18.0),
                              child: ButtonTheme(
                                minWidth: double.maxFinite,
                                height: 50,
                                child: RaisedButton(
                                  onPressed: () async {
                                    //Navigator.pop(context);
                                    List<bool> checks = [
                                      _checkOne,
                                      _checkTwo,
                                      _checkThree,
                                      _checkFour,
                                      _checkFive,
                                      _checkSix,
                                      _checkSeven
                                    ];
                                    await _firestoreSymptomService
                                        .setSymptoms(checks)
                                        .then((value) => {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Text(
                                          'Symptoms Saved',
                                          style:
                                          kReminderMainTextStyle.copyWith(
                                              color: kGreyButtonColor),
                                        ),
                                      ))
                                    });
                                  },
                                  color: kTealColor,
                                  focusColor: kAmberColor,
                                  autofocus: true,
                                  elevation: 10,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Icon(
                                        Icons.check,
                                        size: 26,
                                        color: kLightAmberColor,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Text(
                                          'Done',
                                          style: kDashboardButtonLabelStyle.copyWith(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w100,
                                              color: kLightAmberColor),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
