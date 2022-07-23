import 'package:url_launcher/url_launcher.dart';

class AbridorDeURL {
  static Future<bool> abrir(String url) async {
    Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
      return true;
    }
    return false;
  }
}
