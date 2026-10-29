import 'package:url_launcher/url_launcher.dart';

Future<bool> launchMap({
  double? latitude,
  double? longitude,
  String? address,
}) async {
  Uri uri;
  if (latitude != null && longitude != null) {
    uri = Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude',
    );
  } else {
    final query = Uri.encodeComponent(address ?? '');
    uri = Uri.parse('https://www.google.com/maps/search/?api=1&query=$query');
  }

  if (await canLaunchUrl(uri)) {
    return launchUrl(uri, mode: LaunchMode.externalApplication);
  }
  return false;
}
