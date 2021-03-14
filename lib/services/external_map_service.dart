import 'package:url_launcher/url_launcher.dart';

class ExternalMapService {

  ExternalMapService._();

  static Future<void> openMap(String query) async {
    String googleUrl = 'https://www.google.com/maps/search/?api=1&query=$query';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }
}