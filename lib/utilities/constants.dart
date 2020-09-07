import 'package:flutter/material.dart';

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

final kBgColorGradientArrayBlues = [
  Color(0xFF3594DD),
  Color(0xFF4563DB),
  Color(0xFF5036D5),
  Color(0xFF5b16D0),
];

final kBgColorGradientArrayGreys = [
  Color(0xFF949494),
  Color(0xFFd1d1d1),
  Color(0xFFb5b5b5),
  Color(0xFF949494),
];

// Colors
final kScaffoldBackgroundColor = Color(0xFFedf5f4);
final kLightTealColor = Color(0xffE9F2F1);
final kTealColor = Color(0xff45736A);
final kAmberColor = Color(0xffF2B035);
final kLightAmberColor = Color(0xffF2CA7E);
final kPeachColor = Color(0xffF2AA80);

final kGradientStarterBlueColor = Color(0xFF3594DD);
final kGoldenColor = Color(0xFFffbd00);
final kPurpleColor = Color(0xFF5b16D0);
final kDarkPurpleColor = Color(0xFF451991);
final kDeepGoldenColor = Color(0xFFdbba58);
final kMaroonColor = Color(0xFF8C1212);
final kMapsGreyColor = Color(0xFFf5f5f5);

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
  color: kLightTealColor,
  fontSize: 30.0,
  fontWeight: FontWeight.normal
);

final TextStyle kCustomInputLabelStyle = TextStyle(
  color: kGoldenColor,
  fontSize: 20.0,
  fontFamily: 'CM Sans Serif',
);

final TextStyle kforumHeaderButtonLabelStyle = TextStyle(
  color: kAmberColor,
  fontFamily: 'CM Sans Serif',
);

enum LoadingType {SIGNIN, SIGNUP}



