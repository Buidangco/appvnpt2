import 'package:url_launcher/url_launcher.dart';

Future<bool> launchPhoneCall(String phone) async {
  final uri = Uri(scheme: 'tel', path: phone.trim());
  if (await canLaunchUrl(uri)) {
    return launchUrl(uri);
  }
  return false;
}
