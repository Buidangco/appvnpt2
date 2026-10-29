import 'dart:io';

import 'network_log.dart';

class _TestTlsHttpOverrides extends HttpOverrides {
  _TestTlsHttpOverrides(this.allowedHost);

  final String allowedHost;

  @override
  HttpClient createHttpClient(SecurityContext? context) {
    final client = super.createHttpClient(context);
    client.badCertificateCallback = (cert, host, port) {
      final allowed = host == allowedHost;
      networkLog(
        '[TLS][GLOBAL] badCertificateCallback host=$host port=$port '
        'subject=${cert.subject} allowed=$allowed',
      );
      return allowed;
    };
    return client;
  }
}

void installTestTlsHttpOverrides({
  required bool allowBadTlsForTest,
  required String apiBaseUrl,
}) {
  if (!allowBadTlsForTest) return;

  final apiUri = Uri.tryParse(apiBaseUrl);
  final allowedHost = apiUri?.host;
  if (allowedHost == null || allowedHost.isEmpty) {
    networkError(
      '[TLS][GLOBAL] Skipping HttpOverrides because API_BASE_URL is invalid: '
      '$apiBaseUrl',
    );
    return;
  }

  HttpOverrides.global = _TestTlsHttpOverrides(allowedHost);
  networkLog(
    '[TLS][GLOBAL] Insecure HttpOverrides ENABLED for host=$allowedHost. '
    'TEST-ONLY, DO NOT USE FOR PRODUCTION.',
  );
}
