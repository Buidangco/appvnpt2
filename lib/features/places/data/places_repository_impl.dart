import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/cache/hive_cache_service.dart';
import '../../../core/network/api_exception.dart';
import '../../../core/network/api_client.dart';
import '../domain/entities/category.dart';
import '../domain/entities/district.dart';
import '../domain/entities/place.dart';
import '../domain/repositories/places_repository.dart';
import 'models/category_model.dart';
import 'models/district_model.dart';
import 'models/place_model.dart';
import 'places_remote_data_source.dart';

class PlacesRepositoryImpl implements PlacesRepository {
  PlacesRepositoryImpl(this._remote, this._diskCache);

  final PlacesRemoteDataSource _remote;
  final HiveCacheService _diskCache;
  final Map<String, List<Place>> _listCache = <String, List<Place>>{};
  final Map<String, Place?> _detailCache = <String, Place?>{};

  String _cacheKey({
    String? type,
    String? districtId,
    String? keyword,
    int page = 1,
    int limit = AppConstants.pageSize,
  }) {
    return '$type|$districtId|$keyword|$page|$limit';
  }

  String _diskKey({
    String? type,
    String? districtId,
    String? keyword,
    int page = 1,
    int limit = AppConstants.pageSize,
  }) {
    return 'places:${_cacheKey(type: type, districtId: districtId, keyword: keyword, page: page, limit: limit)}';
  }

  List<Place> getCachedPlaces({
    String? type,
    String? districtId,
    String? keyword,
    int page = 1,
    int limit = AppConstants.pageSize,
  }) {
    final cachedDisk = _diskCache.readMapList(
      _diskKey(
        type: type,
        districtId: districtId,
        keyword: keyword,
        page: page,
        limit: limit,
      ),
    );
    return cachedDisk.map(_placeFromMap).toList();
  }

  @override
  Future<List<Place>> getPlaces({
    String? type,
    String? districtId,
    String? keyword,
    int page = 1,
    int limit = AppConstants.pageSize,
  }) async {
    final key = _cacheKey(
      type: type,
      districtId: districtId,
      keyword: keyword,
      page: page,
      limit: limit,
    );
    final cached = _listCache[key];
    if (cached != null && cached.isNotEmpty) {
      return cached;
    }

    final cachedDisk = getCachedPlaces(
      type: type,
      districtId: districtId,
      keyword: keyword,
      page: page,
      limit: limit,
    );
    if (cachedDisk.isNotEmpty) {
      _listCache[key] = cachedDisk;
      return cachedDisk;
    }

    try {
      final response = await _remote.getPlaces(
        type: type,
        districtId: districtId,
        keyword: keyword,
        page: page,
        limit: limit,
      );
      if (response.isNotEmpty) {
        final mapped = response.map((e) => e.toEntity()).toList();
        _listCache[key] = mapped;
        _savePlacesToDisk(
          mapped,
          type: type,
          districtId: districtId,
          keyword: keyword,
          page: page,
          limit: limit,
        );
        return mapped;
      }
    } on ApiException {
      // fallback to mock
    }

    final mock = await _remote.getMockPlaces();
    final mapped = mock
        .where(
          (e) =>
              (type == null || type.isEmpty || e.type == type) &&
              (districtId == null ||
                  districtId.isEmpty ||
                  districtId == e.districtId),
        )
        .where(
          (e) =>
              keyword == null ||
              keyword.isEmpty ||
              e.name.toLowerCase().contains(keyword.toLowerCase()),
        )
        .map((e) => e.toEntity())
        .toList();
    _listCache[key] = mapped;
    _savePlacesToDisk(
      mapped,
      type: type,
      districtId: districtId,
      keyword: keyword,
      page: page,
      limit: limit,
    );
    return mapped;
  }

  Future<List<Place>> fetchFreshPlaces({
    String? type,
    String? districtId,
    String? keyword,
    int page = 1,
    int limit = AppConstants.pageSize,
  }) async {
    final response = await _remote.getPlaces(
      type: type,
      districtId: districtId,
      keyword: keyword,
      page: page,
      limit: limit,
    );
    final mapped = response.map((e) => e.toEntity()).toList();
    final key = _cacheKey(
      type: type,
      districtId: districtId,
      keyword: keyword,
      page: page,
      limit: limit,
    );
    _listCache[key] = mapped;
    await _savePlacesToDisk(
      mapped,
      type: type,
      districtId: districtId,
      keyword: keyword,
      page: page,
      limit: limit,
    );
    return mapped;
  }

  @override
  Future<Place?> getPlaceDetail(String id) async {
    if (_detailCache.containsKey(id)) {
      return _detailCache[id];
    }

    try {
      final detail = await _remote.getPlaceDetail(id);
      if (detail != null) {
        final mapped = detail.toEntity();
        _detailCache[id] = mapped;
        return mapped;
      }
    } on ApiException {
      // fallback to mock
    }

    final mock = await _remote.getMockPlaces();
    for (final item in mock) {
      if (item.id == id) {
        final mapped = item.toEntity();
        _detailCache[id] = mapped;
        return mapped;
      }
    }
    _detailCache[id] = null;
    return null;
  }

  Future<void> _savePlacesToDisk(
    List<Place> places, {
    String? type,
    String? districtId,
    String? keyword,
    int page = 1,
    int limit = AppConstants.pageSize,
  }) async {
    final key = _diskKey(
      type: type,
      districtId: districtId,
      keyword: keyword,
      page: page,
      limit: limit,
    );
    await _diskCache.writeMapList(key, places.map(_placeToMap).toList());
  }

  Map<String, dynamic> _placeToMap(Place place) {
    return <String, dynamic>{
      'id': place.id,
      'name': place.name,
      'type': place.type,
      'categoryName': place.categoryName,
      'shortDescription': place.shortDescription,
      'description': place.description,
      'address': place.address,
      'phone': place.phone,
      'openingHours': place.openingHours,
      'latitude': place.latitude,
      'longitude': place.longitude,
      'thumbnailUrl': place.thumbnailUrl,
      'imageUrls': place.imageUrls,
      'districtId': place.districtId,
      'districtName': place.districtName,
      'isFeatured': place.isFeatured,
      'updatedAt': place.updatedAt,
    };
  }

  Place _placeFromMap(Map<String, dynamic> map) {
    final imageUrls = (map['imageUrls'] is List)
        ? (map['imageUrls'] as List).map((e) => '$e').toList()
        : <String>[];
    return Place(
      id: '${map['id'] ?? ''}',
      name: '${map['name'] ?? ''}',
      type: map['type']?.toString(),
      categoryName: map['categoryName']?.toString(),
      shortDescription: map['shortDescription']?.toString(),
      description: map['description']?.toString(),
      address: map['address']?.toString(),
      phone: map['phone']?.toString(),
      openingHours: map['openingHours']?.toString(),
      latitude: (map['latitude'] as num?)?.toDouble(),
      longitude: (map['longitude'] as num?)?.toDouble(),
      thumbnailUrl: map['thumbnailUrl']?.toString(),
      imageUrls: imageUrls,
      districtId: map['districtId']?.toString(),
      districtName: map['districtName']?.toString(),
      isFeatured: (map['isFeatured'] as bool?) ?? false,
      updatedAt: map['updatedAt']?.toString(),
    );
  }

  @override
  Future<List<District>> getDistricts() async {
    try {
      final districts = await _remote.getDistricts();
      if (districts.isNotEmpty) {
        return districts.map((e) => e.toEntity()).toList();
      }
    } on ApiException {
      // fallback to mock
    }
    final mock = await _remote.getMockDistricts();
    return mock.map((e) => e.toEntity()).toList();
  }

  @override
  Future<List<Category>> getCategories() async {
    try {
      final categories = await _remote.getCategories();
      if (categories.isNotEmpty) {
        return categories.map((e) => e.toEntity()).toList();
      }
    } on ApiException {
      // fallback to mock
    }
    final mock = await _remote.getMockCategories();
    return mock.map((e) => e.toEntity()).toList();
  }
}

final placesRemoteDataSourceProvider = Provider<PlacesRemoteDataSource>((ref) {
  return PlacesRemoteDataSource(ref.watch(apiClientProvider));
});

final placesRepositoryProvider = Provider<PlacesRepository>((ref) {
  return PlacesRepositoryImpl(
    ref.watch(placesRemoteDataSourceProvider),
    ref.watch(hiveCacheServiceProvider),
  );
});
