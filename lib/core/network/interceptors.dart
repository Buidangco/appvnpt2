import 'package:dio/dio.dart';

import 'network_log.dart';

InterceptorsWrapper buildDebugInterceptor() {
  return InterceptorsWrapper(
    onRequest: (options, handler) {
      networkLog('[REQ] ${options.method} ${options.uri}');
      handler.next(options);
    },
    onResponse: (response, handler) {
      networkLog(
        '[RES] ${response.statusCode} ${response.requestOptions.uri}',
      );
      handler.next(response);
    },
    onError: (error, handler) {
      networkError(
        '[ERR] type=${error.type} status=${error.response?.statusCode} '
        'uri=${error.requestOptions.uri} message=${error.message} '
        'error=${error.error}',
        error,
        error.stackTrace,
      );
      handler.next(error);
    },
  );
}
