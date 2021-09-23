import 'package:url_launcher/url_launcher.dart';

class AbridorDeURL {
  static Future<bool> abrir(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
      return true;
    }
    return false;
  }
}
