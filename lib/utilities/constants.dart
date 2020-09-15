import 'package:flutter/material.dart';

// Colors

final kScaffoldBackgroundColor = Color(0xFFedf5f4);
final kLightTealColor = Color(0xffE9F2F1);
final kTealColor = Color(0xff45736A);
final kAmberColor = Color(0xffF2B035);
final kLightAmberColor = Color(0xffF2CA7E);
final kPeachColor = Color(0xffF2AA80);
final kMapsGreyColor = Color(0xFFf5f5f5);

// Theme Data

final kEyeSeeThemeData = ThemeData(
  backgroundColor: kScaffoldBackgroundColor,
  dialogBackgroundColor: kScaffoldBackgroundColor,
  scaffoldBackgroundColor: kScaffoldBackgroundColor,
);

// Text Styles

final kOnBoardingTitleStyle = TextStyle(
  color: kTealColor,
  fontFamily: 'CM Sans Serif',
  fontSize: 26.0,
  height: 1.5,
);

final kOnBoardingSubtitleStyle = TextStyle(
  color: kTealColor,
  fontSize: 18.0,
  height: 1.2,
);

final kLoginHintTextStyle = TextStyle(
  color: Colors.white54,
  fontFamily: 'CM Sans Serif',
);

final kLoginLabelStyle = TextStyle(
  color: kTealColor,
  fontWeight: FontWeight.bold,
  fontFamily: 'CM Sans Serif',
);

final TextStyle kDashboardTitleTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 32.0,
  fontFamily: 'CM Sans Serif',
);

final TextStyle kDashboardSubtitleTextStyle = TextStyle(
  fontSize: 26.0,
  fontFamily: 'CM Sans Serif',
);

final kDashboardButtonLabelStyle = TextStyle(
  fontSize: 15.0,
  color: kTealColor,
  fontFamily: 'CM Sans Serif',
);

final kBottomNavBarTextStyle = TextStyle(
  fontSize: 22.0,
  color: kTealColor,
  fontFamily: 'CM Sans Serif',
);

final TextStyle kHintTextStyle = TextStyle(
  color: Colors.white54,
  fontFamily: 'CM Sans Serif',
);

final TextStyle kAvatarTextStyle = TextStyle(
    color: kLightTealColor, fontSize: 30.0, fontWeight: FontWeight.normal);

final TextStyle kCustomInputLabelStyle = TextStyle(
  color: kAmberColor,
  fontSize: 20.0,
  fontFamily: 'CM Sans Serif',
);

final TextStyle kforumHeaderButtonLabelStyle = TextStyle(
  color: kAmberColor,
  fontFamily: 'CM Sans Serif',
);

final TextStyle kSpeedDialTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 18.0,
  fontFamily: 'CM Sans Serif',
);

final TextStyle kReminderContainerTextStyle = TextStyle(
  color: kAmberColor,
  fontSize: 20.0,
  fontFamily: 'CM Sans Serif',
);

final TextStyle kReminderBulletsTextStyle = TextStyle(
    color: kScaffoldBackgroundColor, fontFamily: 'CM Sans Serif', fontSize: 16);

final TextStyle kReminderMainTextStyle =
    TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: kTealColor);

final TextStyle kReminderSubtitleTextStyle = TextStyle(
  fontWeight: FontWeight.bold,
  color: kTealColor.withOpacity(0.7),
  fontSize: 15,
  fontStyle: FontStyle.italic,
);

// Enumerations

enum LoadingType { SIGNIN, SIGNUP }

enum ReminderType { RECURRING, ONETIME }

// Decorations

final kLoginBoxDecorationStyle = BoxDecoration(
  color: kTealColor.withOpacity(0.8),
  borderRadius: BorderRadius.circular(10.0),
  boxShadow: [
    BoxShadow(
      color: kLightTealColor,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);
