import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/env.dart';
import '../constants/app_constants.dart';
import 'api_exception.dart';
import 'dio_tls_workaround.dart'
    if (dart.library.io) 'dio_tls_workaround_io.dart';
import 'interceptors.dart';
import 'network_log.dart';

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: Env.apiBaseUrl,
      connectTimeout: AppConstants.connectTimeout,
      receiveTimeout: AppConstants.receiveTimeout,
      contentType: Headers.jsonContentType,
    ),
  );

  configureDioTlsWorkaround(
    dio,
    allowBadTlsForTest: Env.allowBadTlsForTest,
    apiBaseUrl: Env.apiBaseUrl,
  );
  dio.interceptors.add(buildDebugInterceptor());
  return dio;
});

class ApiClient {
  ApiClient(this._dio);

  final Dio _dio;

  Future<Map<String, dynamic>> getObject(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        path,
        queryParameters: queryParameters,
      );
      return response.data ?? <String, dynamic>{};
    } on DioException catch (e) {
      throw _toApiException(e);
    }
  }

  Future<List<dynamic>> getList(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.get<dynamic>(
        path,
        queryParameters: queryParameters,
      );
      final data = response.data;
      if (data is List<dynamic>) {
        return data;
      }
      if (data is Map<String, dynamic>) {
        final items = data['items'];
        if (items is List<dynamic>) {
          return items;
        }
      }
      return <dynamic>[];
    } on DioException catch (e) {
      throw _toApiException(e);
    }
  }

  Future<Map<String, dynamic>> postForm(
    String path, {
    required Map<String, dynamic> data,
  }) async {
    try {
      final response = await _dio.post<dynamic>(
        path,
        data: data,
        options: Options(contentType: Headers.formUrlEncodedContentType),
      );
      final dataObject = response.data;
      networkLog(
        '[API] postForm $path -> ${response.statusCode} type=${dataObject.runtimeType}',
      );
      if (dataObject is Map) {
        networkLog('[API] keys=${dataObject.keys.take(5).toList()}');
      } else if (dataObject is String) {
        networkLog(
          '[API] raw string (first 200): '
          '${dataObject.substring(0, dataObject.length.clamp(0, 200))}',
        );
      }
      return _toMap(dataObject);
    } on DioException catch (e) {
      throw _toApiException(e);
    }
  }

  Future<String> getRaw(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.get<dynamic>(
        path,
        queryParameters: queryParameters,
      );
      final data = response.data;
      if (data is String) {
        return data;
      }
      return '$data';
    } on DioException catch (e) {
      throw _toApiException(e);
    }
  }

  Map<String, dynamic> _toMap(dynamic data) {
    if (data is Map<String, dynamic>) {
      return data;
    }
    if (data is Map) {
      return Map<String, dynamic>.from(data);
    }
    if (data is String && data.trim().startsWith('{')) {
      try {
        final decoded = jsonDecode(data);
        if (decoded is Map<String, dynamic>) return decoded;
        if (decoded is Map) return Map<String, dynamic>.from(decoded);
      } catch (error, stackTrace) {
        networkError(
          '[API] _toMap failed to parse JSON string',
          error,
          stackTrace,
        );
      }
    }
    return <String, dynamic>{};
  }

  ApiException _toApiException(DioException e) {
    final statusCode = e.response?.statusCode;
    final details = _buildErrorDetails(e);
    networkError(
      '[API] DioException '
      'type=${e.type} status=$statusCode uri=${e.requestOptions.uri} '
      'message=${e.message} details=$details',
      e,
      e.stackTrace,
    );

    final message = switch (e.type) {
      DioExceptionType.connectionTimeout => 'Kết nối quá thời gian.',
      DioExceptionType.receiveTimeout => 'Nhận dữ liệu quá thời gian.',
      DioExceptionType.sendTimeout => 'Gửi dữ liệu quá thời gian.',
      DioExceptionType.connectionError => _connectionErrorMessage(),
      _ => e.message ?? 'Đã xảy ra lỗi từ máy chủ.',
    };

    return ApiException(
      message: message,
      statusCode: statusCode,
      details: details,
    );
  }

  String _connectionErrorMessage() {
    if (kIsWeb) {
      return 'Không thể gọi API từ Web (khả năng cao do CORS/chứng chỉ). '
          'Hãy chạy Android/iOS hoặc dùng backend proxy.';
    }
    return 'Không có kết nối mạng.';
  }

  String _buildErrorDetails(DioException e) {
    final responseData = e.response?.data;
    final responsePreview = responseData == null
        ? 'null'
        : '$responseData'.substring(0, '$responseData'.length.clamp(0, 300));
    return 'type=${e.type}; '
        'errorType=${e.error.runtimeType}; '
        'error=${e.error}; '
        'response=$responsePreview';
  }
}

final apiClientProvider = Provider<ApiClient>((ref) {
  return ApiClient(ref.watch(dioProvider));
});
