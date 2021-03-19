import 'package:eye_diagnostic_system/components/header_clipper_component.dart';
import 'package:eye_diagnostic_system/services/auth_service.dart';
import 'package:eye_diagnostic_system/services/biometric_service.dart';
import 'package:eye_diagnostic_system/utilities/constants.dart';
import 'package:eye_diagnostic_system/widgets/alert_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  static const String id = 'profile_screen';

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _biometricsEnabled;
  BiometricService _biometricService = BiometricService();
  bool _isDeviceSupported = true;

  @override
  void initState() {
    super.initState();
    _biometricsEnabled = false;
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    _biometricsEnabled = await _biometricService.isBiometricAuthEnabled();
    _isDeviceSupported = await _biometricService.isDeviceSupported();
    setState(() {});
  }

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
                            text: 'EyeSee\tProfile',
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
                child: Column(
                  children: [
                    CircleAvatar(
                      backgroundColor: kTealColor.withOpacity(0.75),
                      radius: 80,
                      child: Icon(
                        Icons.person,
                        color: kTealColor.withOpacity(0.55),
                        size: 80,
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 18.0, left: 18.0),
                        child: FutureBuilder(
                          future: _getUserName(),
                          builder: (BuildContext context,
                              AsyncSnapshot<dynamic> snapshot) {
                            return Text('${snapshot.data}',
                                style: kDashboardSubtitleTextStyle.copyWith(
                                    color: kTealColor));
                          },
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 6.0, left: 18.0),
                        child: FutureBuilder(
                          future: _getUserEmail(),
                          builder: (BuildContext context,
                              AsyncSnapshot<dynamic> snapshot) {
                            return Text('${snapshot.data}',
                                style: kDashboardSubtitleTextStyle.copyWith(
                                    color: kTealColor.withOpacity(0.8),
                                    fontStyle: FontStyle.italic,
                                    fontSize: 20.0));
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 2,
                      width: size.width - 20,
                      color: kTealColor.withOpacity(0.25),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Biometrics',
                            style: kReminderMainTextStyle,
                          ),
                          _isDeviceSupported ?
                          FlutterSwitch(
                              //duration: Duration(milliseconds: 750),
                              height: 30,
                              width: 55,
                              value: _biometricsEnabled,
                              activeColor: kTealColor,
                              onToggle: (val) async {
                                setState(() {
                                  _biometricsEnabled = val;
                                });

                                // Turn biometrics On
                                if (val) {


                                  try {
                                    val = await _biometricService.authenticateWithBiometrics();
                                  }
                                  catch (err) {
                                    val = false;
                                    print(err.toString());
                                    AlertWidget()
                                    .generateBiometricErrorAlert(
                                        context: context, title: err.toString()
                                    ).show();
                                    setState(() {
                                      _biometricsEnabled = val;
                                    });
                                  }

                                  if (!val){
                                    setState(() {
                                      _biometricsEnabled = val;
                                    });
                                    return;
                                  }

                                  await _biometricService.turnOnBiometrics();
                                }
                                // Turn biometrics Off
                                else if (!val) {
                                  await _biometricService.turnOffBiometrics();
                                  setState(() {
                                    _biometricsEnabled = val;
                                  });
                                }

                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        getSnackBarText(val),
                                        style: kReminderMainTextStyle.copyWith(
                                            color: kGreyButtonColor
                                        ),
                                      ),
                                    )
                                );
                              }) :
                              Text(
                                'Device Unsupported',
                                  style: kReminderMainTextStyle.copyWith(
                                    color: kTealColor.withOpacity(0.85),
                                    fontSize: 16.0
                                  ),
                              )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<String> _getUserName() async {
    String _name;
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString('displayName');
  }

  Future<String> _getUserEmail() async {
    var user = await Auth().getCurrentUser();
    return user.email;
  }

  String getSnackBarText(bool value) {
    if (value){
      return 'Biometric Authentication Enabled!';
    }
    return 'Biometric Authentication Disabled!';
  }
}
