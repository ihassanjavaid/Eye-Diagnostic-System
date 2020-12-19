import 'package:eye_diagnostic_system/screens/assistant_screens/assistant_chatbot_screen.dart';
import 'package:eye_diagnostic_system/screens/assistant_screens/assistant_voice_screen.dart';
import 'package:eye_diagnostic_system/screens/community_screens/forum_detail_screen.dart';
import 'package:eye_diagnostic_system/screens/community_screens/forum_screen.dart';
import 'package:eye_diagnostic_system/screens/diagnosis_screen.dart';
import 'package:eye_diagnostic_system/screens/diagnosis_screens/reporting_screen.dart';
import 'package:eye_diagnostic_system/screens/extras_screen.dart';
import 'package:eye_diagnostic_system/screens/eye_sight_screens/visual_acuity/rules_screen.dart';
import 'package:eye_diagnostic_system/screens/eye_sight_screens/visual_acuity/righteye.dart';
import 'package:eye_diagnostic_system/screens/eye_sight_screens/visual_acuity/left_eye.dart';
import 'package:eye_diagnostic_system/screens/login_screen.dart';
import 'package:eye_diagnostic_system/screens/main_dashboard_screen.dart';
import 'package:eye_diagnostic_system/screens/nearby_medicos_screens/nearby_main_screen.dart';
import 'package:eye_diagnostic_system/screens/on_boarding_screen.dart';
import 'package:eye_diagnostic_system/screens/registration_screen.dart';
import 'package:eye_diagnostic_system/screens/reminder_screens/reminder_main_screen.dart';
import 'package:eye_diagnostic_system/screens/sign_out_screen.dart';
import 'package:eye_diagnostic_system/screens/vision_testing_screens/vision_testing_main.dart';
import 'package:eye_diagnostic_system/services/auto_login_service.dart';
import 'package:eye_diagnostic_system/screens/eye_sight_screens/duo_chrome/duo_chrome_screen.dart';
import 'package:eye_diagnostic_system/screens/eye_sight_screens/duo_chrome/coverleftduo.dart';
import 'package:eye_diagnostic_system/screens/eye_sight_screens/duo_chrome/left_duochrome.dart';
import 'package:eye_diagnostic_system/screens/eye_sight_screens/near_vision_screen.dart';
import 'package:eye_diagnostic_system/screens/eye_sight_screens/contrastSesitivity1_screen.dart';
import 'package:eye_diagnostic_system/screens/eye_sight_screens/contrastSensitivity2_screen.dart';
import 'package:eye_diagnostic_system/screens/eye_sight_screens/menu_screen.dart';
import 'package:eye_diagnostic_system/screens/eye_sight_screens/contrast_sensitivity/contrast_screen1.dart';
import 'package:eye_diagnostic_system/splash.dart';
import 'package:flutter/material.dart';
import 'package:eye_diagnostic_system/screens/eye_sight_screens/contrast_sensitivity/contrast_screen4.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'screens/diagnosis_screens/camera_screen.dart';

class DefaultEyeSeeRoute{
  static Map<String, WidgetBuilder> _defaultRoute = {
    AutoLoginService.id:(context) => AutoLoginService(),
    ContrastScreen1.id:(context) => ContrastScreen1(),
    ForumDetails.id:(context) => ForumDetails(),
    Forum.id:(context) => Forum(),
    LoginScreen.id: (context) => LoginScreen(),
    Dashboard.id: (context) => Dashboard(),
    NearbyMain.id: (context) => NearbyMain(),
    OnBoardingScreen.id: (context) => OnBoardingScreen(),
    RegistrationScreen.id: (context) => RegistrationScreen(),
    Extras.id: (context) => Extras(),
    DiagnosisScreen.id: (context) => DiagnosisScreen(),
    Menu.id: (context) => Menu(),
    VisionTestingMain.id: (context) => VisionTestingMain(),
    DuoChrome.id: (context) => DuoChrome(),
    NearVision.id: (context) => NearVision(),
    ContrastSensitivity.id: (context) => ContrastSensitivity(),
    ContrastSensitivity2.id: (context) => ContrastSensitivity2(),
    Assistant.id: (context) => Assistant(),
    AssistantVoice.id: (context) => AssistantVoice(),
    RuleScreen.id: (context) => RuleScreen(),
    SignOutScreen.id: (context) => SignOutScreen(),
    LeftEye.id: (context) => LeftEye(),
    RightEye.id: (context) => RightEye(),
    ReminderMain.id: (context) => ReminderMain(),
    CoverLeft.id: (context) => CoverLeft(),
    LeftDuochrome.id: (context) => LeftDuochrome(),
    ContrastScreen4.id: (context) => ContrastScreen4(),
    Splash.id: (context) => Splash(),
    ReportingScreen.id: (context) => ReportingScreen(),
    CameraScreen.id: (context) => CameraScreen()
  };

  static Map<String, WidgetBuilder> get DEFAULT_ROUTE => _defaultRoute;
}