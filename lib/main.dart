import 'package:eye_diagnostic_system/screens/community_screens/forum_detail_screen.dart';
import 'package:eye_diagnostic_system/screens/community_screens/forum_screen.dart';
import 'package:eye_diagnostic_system/screens/extras_screen.dart';
import 'package:eye_diagnostic_system/screens/login_screen.dart';
import 'package:eye_diagnostic_system/screens/main_dashboard_screen.dart';
import 'package:eye_diagnostic_system/screens/nearby_medicos_screen.dart';
import 'package:eye_diagnostic_system/screens/on_boarding_screen.dart';
import 'package:eye_diagnostic_system/screens/registration_screen.dart';
import 'package:eye_diagnostic_system/services/auto_login_service.dart';
import 'package:eye_diagnostic_system/screens/eyesightscreens/duo_chrome_screen.dart';
import 'package:eye_diagnostic_system/screens/eyesightscreens/near_vision_screen.dart';
import 'package:eye_diagnostic_system/screens/eyesightscreens/contrastSesitivity1_screen.dart';
import 'package:eye_diagnostic_system/screens/eyesightscreens/contrastSensitivity2_screen.dart';
import 'package:eye_diagnostic_system/screens/eyesightscreens/menu_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(EyeSee());
}

class EyeSee extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Eye See',
      initialRoute: Menu.id,
      routes: {
        AutoLoginService.id:(context) => AutoLoginService(),
        ForumDetails.id:(context) => ForumDetails(),
        Forum.id:(context) => Forum(),
        LoginScreen.id: (context) => LoginScreen(),
        Dashboard.id: (context) => Dashboard(),
        NearbyMedicos.id: (context) => NearbyMedicos(),
        OnBoardingScreen.id: (context) => OnBoardingScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        Extras.id: (context) => Extras(),
        Menu.id: (context) => Menu(),
        DuoChrome.id: (context) => DuoChrome(),
        NearVision.id: (context) => NearVision(),
        ContrastSensitivity.id: (context) => ContrastSensitivity(),
        ContrastSensitivity2.id: (context) => ContrastSensitivity2()
      },
    );
  }
}
