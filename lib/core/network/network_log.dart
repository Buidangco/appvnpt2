import 'dart:developer' as developer;

void networkLog(String message) {
  developer.log(message, name: 'NETWORK');
}

void networkError(String message, [Object? error, StackTrace? stackTrace]) {
  developer.log(
    message,
    name: 'NETWORK',
    error: error,
    stackTrace: stackTrace,
    level: 1000,
  );
}
