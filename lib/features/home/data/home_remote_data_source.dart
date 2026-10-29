import 'dart:convert';

import 'package:flutter/services.dart';

import '../../../app/env.dart';
import '../../../core/constants/api_endpoints.dart';
import '../../../core/network/api_client.dart';
import '../../../core/utils/text_utils.dart';
import 'models/banner_model.dart';

class HomeRemoteDataSource {
  HomeRemoteDataSource(this._apiClient);

  final ApiClient _apiClient;

  Future<List<BannerModel>> getBanners() async {
    final response = await _apiClient.postForm(
      ApiEndpoints.banners,
      data: <String, dynamic>{
        'type': '2',
        'uservn': Env.apiUsername,
        'passvn': Env.apiPassword,
      },
    );
    final list = (response['list_dulieu'] as List?) ?? <dynamic>[];
    return list
        .whereType<Map>()
        .map((e) => Map<String, dynamic>.from(e))
        .map(_parseBanner)
        .toList();
  }

  Future<List<BannerModel>> getMockBanners() async {
    final raw = await rootBundle.loadString('assets/mock/banners.json');
    final data = jsonDecode(raw) as List<dynamic>;
    return data.whereType<Map<String, dynamic>>().map(_parseBanner).toList();
  }

  BannerModel _parseBanner(Map<String, dynamic> json) {
    final normalized = Map<String, dynamic>.from(json);
    normalized['id'] = '${normalized['id'] ?? ''}';
    normalized['title'] = fixVietnameseEncoding(
      normalized['title'] ?? 'Du lịch Hưng Yên',
    );
    normalized['imageUrl'] = _normalizeAssetUrl(
      normalized['imageUrl'] ?? normalized['image'] ?? normalized['url'],
    );
    return BannerModel.fromJson(normalized);
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
