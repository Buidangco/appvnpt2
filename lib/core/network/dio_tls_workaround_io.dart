import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';

import 'network_log.dart';

void configureDioTlsWorkaround(
  Dio dio, {
  required bool allowBadTlsForTest,
  required String apiBaseUrl,
}) {
  if (!allowBadTlsForTest) return;

  final apiUri = Uri.tryParse(apiBaseUrl);
  final allowedHost = apiUri?.host;
  if (allowedHost == null || allowedHost.isEmpty) {
    networkError(
      '[TLS] Skipping insecure TLS workaround because API_BASE_URL is invalid: '
      '$apiBaseUrl',
    );
    return;
  }

  final adapter = dio.httpClientAdapter;
  if (adapter is! IOHttpClientAdapter) {
    networkError(
      '[TLS] Skipping insecure TLS workaround because adapter is not IOHttpClientAdapter: '
      '${adapter.runtimeType}',
    );
    return;
  }

  // TEST-ONLY INSECURE WORKAROUND:
  // This bypasses certificate validation for the configured upstream host.
  // Do not enable in production/store builds.
  adapter.createHttpClient = () {
    final client = HttpClient();
    client.badCertificateCallback = (cert, host, port) {
      final allowed = host == allowedHost;
      networkLog(
        '[TLS] badCertificateCallback host=$host port=$port '
        'subject=${cert.subject} allowed=$allowed',
      );
      return allowed;
    };
    return client;
  };

  networkLog(
    '[TLS] Insecure TLS workaround ENABLED for host=$allowedHost. '
    'TEST-ONLY, DO NOT USE FOR PRODUCTION.',
  );
}
