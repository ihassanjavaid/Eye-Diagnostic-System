import 'package:eye_diagnostic_system/screens/assistant_screens/assistant_chatbot_screen.dart';
import 'package:eye_diagnostic_system/screens/community_screens/forum_screen.dart';
import 'package:eye_diagnostic_system/screens/extras_screen.dart';
import 'package:eye_diagnostic_system/screens/main_dashboard_screen.dart';
import 'package:eye_diagnostic_system/screens/nearby_medicos_screens/nearby_main_screen.dart';
import 'package:eye_diagnostic_system/screens/reminder_screens/reminder_main_screen.dart';
import 'package:eye_diagnostic_system/screens/sign_out_screen.dart';

class Pages{
  static List<String> _pagesList = [
    Forum.id,
    Dashboard.id,
    NearbyMain.id, /// TODO make intent
    Extras.id,
    Assistant.id,
    SignOutScreen.id,
    ReminderMain.id /// TODO make intent
  ];

  static bool isAvailable(String givenPage) => _pagesList.contains(givenPage);
}