import 'dart:convert';

import 'package:flutter/services.dart';

import '../../../app/env.dart';
import '../../../core/constants/api_endpoints.dart';
import '../../../core/network/api_client.dart';
import '../../../core/utils/text_utils.dart';
import 'models/news_model.dart';

class NewsRemoteDataSource {
  NewsRemoteDataSource(this._apiClient);

  final ApiClient _apiClient;
  bool? _opReachable;

  Future<List<NewsModel>> getNews({
    String? category,
    String? keyword,
    int page = 1,
    int limit = 20,
  }) async {
    final response = await _apiClient.postForm(
      ApiEndpoints.news,
      data: <String, dynamic>{
        'idcate': (category == null || category == 'all') ? '5' : category,
        'page': page.toString(),
        'uservn': Env.apiUsername,
        'passvn': Env.apiPassword,
      },
    );

    final list = (response['dal_tintuc'] as List?) ?? <dynamic>[];
    var results = list
        .whereType<Map>()
        .map((e) => Map<String, dynamic>.from(e))
        .map(_parseNews)
        .toList();

    if (keyword != null && keyword.trim().isNotEmpty) {
      final k = keyword.toLowerCase();
      results = results.where((e) => e.title.toLowerCase().contains(k)).toList();
    }

    return results;
  }

  Future<bool> probeLayDsTintucOperationPage() async {
    try {
      final html = await _apiClient.getRaw(
        '',
        queryParameters: <String, dynamic>{'op': 'Lay_ds_tintuc'},
      );
      _opReachable =
          html.contains('Lay_ds_tintuc') && html.contains('home Web Service');
      return _opReachable ?? false;
    } catch (_) {
      _opReachable = false;
      return false;
    }
  }

  Future<List<NewsModel>> getFeaturedNews() async {
    final response = await _apiClient.postForm(
      ApiEndpoints.featuredNews,
      data: <String, dynamic>{
        'type': '1',
        'idcate': '5',
        'uservn': Env.apiUsername,
        'passvn': Env.apiPassword,
      },
    );

    final list = (response['dal_tintuc'] as List?) ?? <dynamic>[];
    return list
        .whereType<Map>()
        .map((e) => Map<String, dynamic>.from(e))
        .map(_parseNews)
        .toList();
  }

  Future<NewsModel?> getNewsDetail(String id) async {
    final object = await _apiClient.postForm(
      ApiEndpoints.newsDetail,
      data: <String, dynamic>{
        'id': id,
        'uservn': Env.apiUsername,
        'passvn': Env.apiPassword,
      },
    );

    final detail = object['dal_tintuc'];
    if (detail is Map) {
      return _parseNews(Map<String, dynamic>.from(detail));
    }
    if (detail is List && detail.isNotEmpty && detail.first is Map) {
      return _parseNews(Map<String, dynamic>.from(detail.first as Map));
    }
    return null;
  }

  Future<List<NewsModel>> getMockNews() async {
    final raw = await rootBundle.loadString('assets/mock/news.json');
    final data = jsonDecode(raw) as List<dynamic>;
    return data.whereType<Map<String, dynamic>>().map(_parseNews).toList();
  }

  NewsModel _parseNews(Map<String, dynamic> json) {
    final normalized = Map<String, dynamic>.from(json);
    final images = normalized['imageUrls'] ?? normalized['images'];

    normalized['id'] = '${normalized['id'] ?? ''}';
    normalized['title'] = fixVietnameseEncoding(
      normalized['title'] ?? 'Tin tức',
    );
    normalized['summary'] = fixVietnameseEncoding(
      normalized['summary'] ?? normalized['sampo'] ?? '',
    );
    normalized['content'] = fixVietnameseEncoding(
      normalized['content'] ?? normalized['conten'] ?? '',
    );
    normalized['thumbnailUrl'] = _normalizeAssetUrl(
      normalized['thumbnailUrl'] ?? normalized['avata'] ?? normalized['image'],
    );
    normalized['publishedAt'] =
        normalized['publishedAt'] ?? normalized['datepub'] ?? '';
    normalized['updatedAt'] =
        normalized['updatedAt'] ?? normalized['datepub'] ?? '';
    normalized['categoryName'] = fixVietnameseEncoding(
      normalized['categoryName'] ??
          normalized['idcate']?.toString() ??
          'Tin tức',
    );
    normalized['imageUrls'] = (images is List)
        ? images.map(_normalizeAssetUrl).where((e) => e.isNotEmpty).toList()
        : <String>[];
    normalized['contentType'] = normalized['contentType'] ?? 'html';

    return NewsModel.fromJson(normalized);
  }

  String _normalizeAssetUrl(dynamic rawUrl) {
    final url = rawUrl?.toString().trim() ?? '';
    if (url.isEmpty) return '';
    if (url.startsWith('http://') || url.startsWith('https://')) return url;
    if (url.startsWith('//')) return 'https:$url';
    if (url.startsWith('/')) return 'https://hungyentourism.com.vn$url';
    return 'https://hungyentourism.com.vn/$url';
  }
}
