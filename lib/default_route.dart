import 'package:camera/camera.dart';
import 'package:eye_diagnostic_system/screens/assistant_screens/assistant_chatbot_screen.dart';
import 'package:eye_diagnostic_system/screens/assistant_screens/assistant_voice_screen.dart';
import 'package:eye_diagnostic_system/screens/community_screens/forum_detail_screen.dart';
import 'package:eye_diagnostic_system/screens/community_screens/forum_screen.dart';
import 'package:eye_diagnostic_system/screens/diagnosis_screen.dart';
import 'package:eye_diagnostic_system/screens/diagnosis_screens/image_picker_screen.dart';
import 'package:eye_diagnostic_system/screens/diagnosis_screens/reporting_screen.dart';
import 'package:eye_diagnostic_system/screens/extras_screen.dart';
import 'package:eye_diagnostic_system/screens/login_screen.dart';
import 'package:eye_diagnostic_system/screens/main_dashboard_screen.dart';
import 'package:eye_diagnostic_system/screens/nearby_medicos_screens/mapbox_main_screen.dart';
import 'package:eye_diagnostic_system/screens/nearby_medicos_screens/nearby_main_screen.dart';
import 'package:eye_diagnostic_system/screens/on_boarding_screen.dart';
import 'package:eye_diagnostic_system/screens/registration_screen.dart';
import 'package:eye_diagnostic_system/screens/reminder_screens/reminder_main_screen.dart';
import 'package:eye_diagnostic_system/screens/sign_out_screen.dart';
import 'package:eye_diagnostic_system/screens/vision_testing_screens/duochrome_instructions_screen.dart';
import 'package:eye_diagnostic_system/screens/vision_testing_screens/visual_acuity_instructions_screen.dart';
import 'package:eye_diagnostic_system/screens/vision_testing_screens/duochrome_test_screen.dart';
import 'package:eye_diagnostic_system/screens/vision_testing_screens/vision_testing_main.dart';
import 'package:eye_diagnostic_system/screens/vision_testing_screens/vision_result_screen.dart';
import 'package:eye_diagnostic_system/services/auto_login_service.dart';
import 'package:eye_diagnostic_system/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'screens/diagnosis_screens/camera_screen.dart';
import 'screens/profile_screen.dart';

class DefaultEyeSeeRoute{

  static Map<String, WidgetBuilder> _defaultRoute = {
    AutoLoginService.id:(context) => AutoLoginService(),
    //ContrastScreen1.id:(context) => ContrastScreen1(),
    ForumDetails.id:(context) => ForumDetails(),
    Forum.id:(context) => Forum(),
    LoginScreen.id: (context) => LoginScreen(),
    Dashboard.id: (context) => Dashboard(),
    NearbyMain.id: (context) => NearbyMain(),
    OnBoardingScreen.id: (context) => OnBoardingScreen(),
    RegistrationScreen.id: (context) => RegistrationScreen(),
    Extras.id: (context) => Extras(),
    DiagnosisScreen.id: (context) => DiagnosisScreen(),
    //Menu.id: (context) => Menu(),
    VisionTestingMain.id: (context) => VisionTestingMain(),
    //DuoChrome.id: (context) => DuoChrome(),
    //NearVision.id: (context) => NearVision(),
    //ContrastSensitivity.id: (context) => ContrastSensitivity(),
    //ContrastSensitivity2.id: (context) => ContrastSensitivity2(),
    Assistant.id: (context) => Assistant(),
    AssistantVoice.id: (context) => AssistantVoice(),
    //.id: (context) => RuleScreen(),
    SignOutScreen.id: (context) => SignOutScreen(),
    //LeftEye.id: (context) => LeftEye(),
    //RightEye.id: (context) => RightEye(),
    ReminderMain.id: (context) => ReminderMain(),
    //CoverLeft.id: (context) => CoverLeft(),
    //LeftDuochrome.id: (context) => LeftDuochrome(),
    //ContrastScreen4.id: (context) => ContrastScreen4(),
    Splash.id: (context) => Splash(),
    ReportingScreen.id: (context) => ReportingScreen(),
    CameraScreen.id: (context) => CameraScreen(),
    //   CameraScreen.id: (context) {
    //     return CameraScreen(camera: this.camera);
    //   },
    //   //ErrorScreen.id: (context) => ErrorScreen(),
    //FetchingResultsScreen.id: (context) => FetchingResultsScreen(),
    ImagePickerScreen.id: (context) => ImagePickerScreen(),
    MapBoxMainScreen.id: (context) => MapBoxMainScreen(),
    DuoChromeInstructionsScreen.id: (context) => DuoChromeInstructionsScreen(),
    DuochromeTestScreen.id: (context) => DuochromeTestScreen(),
    VisualAcuityInstructionsScreen.id: (context) => VisualAcuityInstructionsScreen(),
    VisionResultScreen.id : (context) => VisionResultScreen(),
    ProfileScreen.id: (context) => ProfileScreen(),
    };

  static Map<String, WidgetBuilder> get DEFAULT_ROUTE => _defaultRoute;
}