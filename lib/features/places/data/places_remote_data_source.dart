import 'dart:convert';

import 'package:flutter/services.dart';

import '../../../app/env.dart';
import '../../../core/constants/api_endpoints.dart';
import '../../../core/network/api_client.dart';
import '../../../core/utils/text_utils.dart';
import 'models/category_model.dart';
import 'models/district_model.dart';
import 'models/place_model.dart';

class PlacesRemoteDataSource {
  PlacesRemoteDataSource(this._apiClient);

  final ApiClient _apiClient;

  Future<List<PlaceModel>> getPlaces({
    String? type,
    String? districtId,
    String? keyword,
    int page = 1,
    int limit = 20,
  }) async {
    final response = await _apiClient.postForm(
      ApiEndpoints.places,
      // Backend only accepts this exact parameter set for Lay_ds_diadiem.
      // `districtId` remains in the method signature only for interface
      // compatibility; it must not affect the request.
      data: _buildPlacesRequest(type: type, keyword: keyword, page: page),
    );

    final list = (response['Listdiadiem'] as List?) ?? <dynamic>[];
    return list
        .whereType<Map>()
        .map((e) => Map<String, dynamic>.from(e))
        .map(_parsePlace)
        .toList();
  }

  Future<PlaceModel?> getPlaceDetail(String id) async {
    final object = await _apiClient.postForm(
      ApiEndpoints.placeDetail,
      data: <String, dynamic>{
        'id': id,
        'uservn': Env.apiUsername,
        'passvn': Env.apiPassword,
      },
    );

    final rawDetail = object['detail_diadiem'];
    final data = rawDetail is Map
        ? Map<String, dynamic>.from(rawDetail)
        : object;
    if (data.isEmpty) return null;
    return _parsePlace(data);
  }

  Future<List<DistrictModel>> getDistricts() async {
    final places = await getMockPlaces();
    final map = <String, String>{};
    for (final place in places) {
      final id = (place.districtId ?? '').trim();
      final name = (place.districtName ?? '').trim();
      if (id.isNotEmpty && name.isNotEmpty) {
        map[id] = name;
      }
    }
    return map.entries
        .map((entry) => DistrictModel(id: entry.key, name: entry.value))
        .toList();
  }

  Future<List<CategoryModel>> getCategories() async {
    return const <CategoryModel>[
      CategoryModel(
        id: 'c1',
        name: 'Đi đâu',
        type: 'destination',
        iconName: 'place',
      ),
      CategoryModel(
        id: 'c2',
        name: 'Ăn gì',
        type: 'food',
        iconName: 'restaurant',
      ),
      CategoryModel(id: 'c3', name: 'Ở đâu', type: 'stay', iconName: 'hotel'),
      CategoryModel(
        id: 'c4',
        name: 'Di chuyển',
        type: 'transport',
        iconName: 'directions_bus',
      ),
    ];
  }

  Future<List<PlaceModel>> getMockPlaces() async {
    final raw = await rootBundle.loadString('assets/mock/places.json');
    final data = jsonDecode(raw) as List<dynamic>;
    return data.whereType<Map<String, dynamic>>().map(_parsePlace).toList();
  }

  Future<List<DistrictModel>> getMockDistricts() async {
    final raw = await rootBundle.loadString('assets/mock/districts.json');
    final data = jsonDecode(raw) as List<dynamic>;
    return data
        .whereType<Map<String, dynamic>>()
        .map((e) => DistrictModel.fromJson(_normalizeMap(e)))
        .where((district) => district.id.trim().isNotEmpty && district.id != 'all')
        .toList();
  }

  Future<List<CategoryModel>> getMockCategories() async {
    final raw = await rootBundle.loadString('assets/mock/categories.json');
    final data = jsonDecode(raw) as List<dynamic>;
    return data
        .whereType<Map<String, dynamic>>()
        .map((e) => CategoryModel.fromJson(_normalizeMap(e)))
        .toList();
  }

  PlaceModel _parsePlace(Map<String, dynamic> json) {
    final normalized = _normalizeMap(json);
    final images =
        normalized['imageUrls'] ?? normalized['images'] ?? normalized['list_anh'];

    normalized['id'] = '${normalized['id'] ?? ''}';
    normalized['name'] = fixVietnameseEncoding(
      normalized['name'] ??
          normalized['title'] ??
          normalized['ten'] ??
          'Địa điểm',
    );
    normalized['shortDescription'] = fixVietnameseEncoding(
      normalized['shortDescription'] ??
          normalized['sampo'] ??
          normalized['description'],
    );
    normalized['description'] = fixVietnameseEncoding(
      normalized['description'] ??
          normalized['contents'] ??
          normalized['conten'] ??
          normalized['_long'] ??
          normalized['content'],
    );
    normalized['address'] = fixVietnameseEncoding(
      normalized['address'] ?? normalized['diachi'],
    );
    normalized['phone'] =
        normalized['phone'] ?? normalized['dienthoai'] ?? normalized['sdt'];
    normalized['thumbnailUrl'] =
        _normalizeAssetUrl(
          normalized['thumbnailUrl'] ??
              normalized['avata'] ??
              normalized['image'],
        );
    normalized['districtName'] = fixVietnameseEncoding(
      normalized['districtName'] ?? normalized['quanhuyen'],
    );
    normalized['districtId'] = _normalizeDistrictId(
      normalized['districtId'],
      normalized['districtName'],
    );
    normalized['type'] = normalized['type']?.toString();
    normalized['categoryName'] = fixVietnameseEncoding(
      normalized['categoryName'] ?? normalized['tencate'],
    );
    normalized['openingHours'] =
        normalized['openingHours'] ?? normalized['open_time'] ?? normalized['mocua'];
    normalized['updatedAt'] = normalized['updatedAt'] ?? normalized['datepub'];
    normalized['isFeatured'] = normalized['isFeatured'] ?? false;
    normalized['imageUrls'] = _normalizeImageUrls(images);

    normalized['latitude'] = _toDouble(normalized['latitude']);
    normalized['longitude'] = _toDouble(normalized['longitude']);

    return PlaceModel.fromJson(normalized);
  }

  Map<String, dynamic> _normalizeMap(Map<String, dynamic> input) {
    return Map<String, dynamic>.from(input);
  }

  // Maps the app's category type to the backend `type` code of Lay_ds_diadiem.
  // Any non-zero `idcate` is rejected by the backend, so only `type` filters.
  static const Map<String, String> _apiTypeCodes = <String, String>{
    'destination': '1',
    'food': '2',
    'stay': '3',
    'transport': '4',
  };

  Map<String, dynamic> _buildPlacesRequest({
    String? type,
    String? keyword,
    int page = 1,
  }) {
    return <String, dynamic>{
      'key': keyword?.trim() ?? '',
      'idcate': '0',
      'page': page.toString(),
      'quanhuyen': '0',
      'type': _apiTypeCodes[type] ?? '1',
      'uservn': Env.apiUsername,
      'passvn': Env.apiPassword,
    };
  }

  String? _normalizeDistrictId(dynamic districtId, dynamic districtName) {
    final rawId = districtId?.toString().trim();
    if (rawId != null && rawId.isNotEmpty && rawId != 'all') {
      return rawId;
    }

    final rawName = fixVietnameseEncoding(districtName?.toString()).trim();
    if (rawName.isEmpty) return null;

    return rawName
        .toLowerCase()
        .replaceAll('đ', 'd')
        .replaceAll(RegExp(r'[^a-z0-9]+'), '_')
        .replaceAll(RegExp(r'^_+|_+$'), '');
  }

  List<String> _normalizeImageUrls(dynamic images) {
    if (images is! List) return <String>[];

    return images
        .map((image) {
          if (image is Map) {
            final map = Map<String, dynamic>.from(image);
            return _normalizeAssetUrl(
              map['url'] ?? map['imageUrl'] ?? map['image'],
            );
          }
          return _normalizeAssetUrl(image);
        })
        .whereType<String>()
        .where((url) => url.isNotEmpty)
        .toList();
  }

  String _normalizeAssetUrl(dynamic rawUrl) {
    final url = rawUrl?.toString().trim() ?? '';
    if (url.isEmpty) return '';
    if (url.startsWith('http://') || url.startsWith('https://')) return url;
    if (url.startsWith('//')) return 'https:$url';
    if (url.startsWith('/')) return 'https://hungyentourism.com.vn$url';
    return 'https://hungyentourism.com.vn/$url';
  }

  double? _toDouble(dynamic value) {
    if (value == null) return null;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    return double.tryParse(value.toString());
  }
}
