class Env {
  const Env._();

  static const String apiBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'https://hungyentourism.com.vn/api/home.asmx',
  );

  static const String apiUsername = String.fromEnvironment(
    'API_USERNAME',
    defaultValue: 'VNPT@manhbeo123',
  );

  static const String apiPassword = String.fromEnvironment(
    'API_PASSWORD',
    defaultValue: 'Manhbeo@123@9897',
  );

  // TEST-ONLY: never enable this in production/store builds.
  static const bool allowBadTlsForTest = bool.fromEnvironment(
    'ALLOW_BAD_TLS_FOR_TEST',
    defaultValue: false,
  );
}
