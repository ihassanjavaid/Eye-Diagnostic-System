import 'package:eye_diagnostic_system/models/provider_data.dart';
import 'package:eye_diagnostic_system/screens/assistant_screens/assistant_chatbot_screen.dart';
import 'package:eye_diagnostic_system/screens/assistant_screens/assistant_voice_screen.dart';
import 'package:eye_diagnostic_system/screens/community_screens/forum_detail_screen.dart';
import 'package:eye_diagnostic_system/screens/community_screens/forum_screen.dart';
import 'package:eye_diagnostic_system/screens/diagnosis_screen.dart';
import 'package:eye_diagnostic_system/screens/extras_screen.dart';
import 'package:eye_diagnostic_system/screens/eye_sight_screens/rules_screen.dart';
import 'package:eye_diagnostic_system/screens/eye_sight_screens/visual_acuity/test_1/category1_screen.dart';
import 'package:eye_diagnostic_system/screens/login_screen.dart';
import 'package:eye_diagnostic_system/screens/main_dashboard_screen.dart';
import 'package:eye_diagnostic_system/screens/on_boarding_screen.dart';
import 'package:eye_diagnostic_system/screens/registration_screen.dart';
import 'package:eye_diagnostic_system/screens/reminder_screens/reminder_main_screen.dart';
import 'package:eye_diagnostic_system/screens/sign_out_screen.dart';
import 'package:eye_diagnostic_system/services/auto_login_service.dart';
import 'package:eye_diagnostic_system/screens/eye_sight_screens/duo_chrome_screen.dart';
import 'package:eye_diagnostic_system/screens/eye_sight_screens/near_vision_screen.dart';
import 'package:eye_diagnostic_system/screens/eye_sight_screens/contrastSesitivity1_screen.dart';
import 'package:eye_diagnostic_system/screens/eye_sight_screens/contrastSensitivity2_screen.dart';
import 'package:eye_diagnostic_system/screens/eye_sight_screens/menu_screen.dart';
import 'package:eye_diagnostic_system/utilities/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'screens/nearby_medicos_screens/nearby_main_screen.dart';

void main() async {
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });
  // Necessary for G-Sign in
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(EyeSee());
}

class EyeSee extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => ProviderData(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Eye See',
        theme: ThemeData(
          backgroundColor: kScaffoldBackgroundColor,
          dialogBackgroundColor: kScaffoldBackgroundColor,
          scaffoldBackgroundColor: kScaffoldBackgroundColor,
        ),
        initialRoute: AutoLoginService.id,
        routes: {
          AutoLoginService.id:(context) => AutoLoginService(),
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
          DuoChrome.id: (context) => DuoChrome(),
          NearVision.id: (context) => NearVision(),
          ContrastSensitivity.id: (context) => ContrastSensitivity(),
          ContrastSensitivity2.id: (context) => ContrastSensitivity2(),
          Assistant.id: (context) => Assistant(),
          AssistantVoice.id: (context) => AssistantVoice(),
          RuleScreen.id: (context) => RuleScreen(),
          SignOutScreen.id: (context) => SignOutScreen(),
          Category1.id: (context) => Category1(),
          ReminderMain.id: (context) => ReminderMain(),
        },
      ),
    );
  }
}
