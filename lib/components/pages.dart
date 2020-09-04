import 'package:eye_diagnostic_system/screens/assistant_screens/assistant_chatbot_screen.dart';
import 'package:eye_diagnostic_system/screens/community_screens/forum_screen.dart';
import 'package:eye_diagnostic_system/screens/extras_screen.dart';
import 'package:eye_diagnostic_system/screens/main_dashboard_screen.dart';
import 'package:eye_diagnostic_system/screens/nearby_medicos_screens/nearby_main_screen.dart';
import 'package:eye_diagnostic_system/screens/sign_out_screen.dart';

class Pages{
  static List<String> _pagesList = [
    Forum.id,
    Dashboard.id,
    NearbyMain.id,
    Extras.id,
    Assistant.id,
    SignOutScreen.id
  ];

  static bool isAvailable(String givenPage){
    return _pagesList.contains(givenPage);
  }
}