import 'package:dio/dio.dart';

void configureDioTlsWorkaround(
  Dio dio, {
  required bool allowBadTlsForTest,
  required String apiBaseUrl,
}) {
  // No-op on platforms without dart:io.
}
