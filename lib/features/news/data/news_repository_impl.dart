import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/cache/hive_cache_service.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/network/api_client.dart';
import '../../../core/network/api_exception.dart';
import '../domain/entities/news_item.dart';
import '../domain/repositories/news_repository.dart';
import 'models/news_model.dart';
import 'news_remote_data_source.dart';

class NewsRepositoryImpl implements NewsRepository {
  NewsRepositoryImpl(this._remote, this._diskCache);

  final NewsRemoteDataSource _remote;
  final HiveCacheService _diskCache;
  final Map<String, List<NewsItem>> _listCache = <String, List<NewsItem>>{};
  final Map<String, NewsItem?> _detailCache = <String, NewsItem?>{};
  List<NewsItem>? _featuredCache;

  String _cacheKey({
    String? category,
    String? keyword,
    int page = 1,
    int limit = AppConstants.pageSize,
  }) {
    return '$category|$keyword|$page|$limit';
  }

  String _diskKey({
    String? category,
    String? keyword,
    int page = 1,
    int limit = AppConstants.pageSize,
  }) {
    return 'news:${_cacheKey(category: category, keyword: keyword, page: page, limit: limit)}';
  }

  List<NewsItem> getCachedNews({
    String? category,
    String? keyword,
    int page = 1,
    int limit = AppConstants.pageSize,
  }) {
    final cached = _diskCache.readMapList(
      _diskKey(category: category, keyword: keyword, page: page, limit: limit),
    );
    return cached.map(_newsFromMap).toList();
  }

  @override
  Future<List<NewsItem>> getNews({
    String? category,
    String? keyword,
    int page = 1,
    int limit = AppConstants.pageSize,
  }) async {
    final key = _cacheKey(
      category: category,
      keyword: keyword,
      page: page,
      limit: limit,
    );
    final cached = _listCache[key];
    if (cached != null && cached.isNotEmpty) {
      return cached;
    }

    final cachedDisk = getCachedNews(
      category: category,
      keyword: keyword,
      page: page,
      limit: limit,
    );
    if (cachedDisk.isNotEmpty) {
      _listCache[key] = cachedDisk;
      return cachedDisk;
    }

    try {
      final data = await _remote.getNews(
        category: category,
        keyword: keyword,
        page: page,
        limit: limit,
      );
      if (data.isNotEmpty) {
        final mapped = data.map((e) => e.toEntity()).toList();
        _listCache[key] = mapped;
        _saveNewsToDisk(
          mapped,
          category: category,
          keyword: keyword,
          page: page,
          limit: limit,
        );
        return mapped;
      }
    } on ApiException {
      await _remote.probeLayDsTintucOperationPage();
    }

    final mock = await _remote.getMockNews();
    final mapped = mock
        .where(
          (e) =>
              category == null ||
              category == 'all' ||
              e.categoryName == category,
        )
        .where(
          (e) =>
              keyword == null ||
              keyword.isEmpty ||
              e.title.toLowerCase().contains(keyword.toLowerCase()),
        )
        .map((e) => e.toEntity())
        .toList();
    final start = ((page <= 1 ? 1 : page) - 1) * limit;
    final end = (start + limit).clamp(0, mapped.length);
    final paged = start >= mapped.length ? <NewsItem>[] : mapped.sublist(start, end);
    _listCache[key] = paged;
    _saveNewsToDisk(
      paged,
      category: category,
      keyword: keyword,
      page: page,
      limit: limit,
    );
    return paged;
  }

  Future<List<NewsItem>> fetchFreshNews({
    String? category,
    String? keyword,
    int page = 1,
    int limit = AppConstants.pageSize,
  }) async {
    final data = await _remote.getNews(
      category: category,
      keyword: keyword,
      page: page,
      limit: limit,
    );
    final mapped = data.map((e) => e.toEntity()).toList();
    final key = _cacheKey(
      category: category,
      keyword: keyword,
      page: page,
      limit: limit,
    );
    _listCache[key] = mapped;
    await _saveNewsToDisk(
      mapped,
      category: category,
      keyword: keyword,
      page: page,
      limit: limit,
    );
    return mapped;
  }

  @override
  Future<List<NewsItem>> getFeaturedNews() async {
    if (_featuredCache != null && _featuredCache!.isNotEmpty) {
      return _featuredCache!;
    }

    try {
      final data = await _remote.getFeaturedNews();
      if (data.isNotEmpty) {
        final mapped = data.map((e) => e.toEntity()).toList();
        _featuredCache = mapped;
        return mapped;
      }
    } on ApiException {
      // fallback to mock
    }

    final mock = await _remote.getMockNews();
    final mapped = mock.take(5).map((e) => e.toEntity()).toList();
    _featuredCache = mapped;
    return mapped;
  }

  @override
  Future<NewsItem?> getNewsDetail(String id) async {
    if (_detailCache.containsKey(id)) {
      return _detailCache[id];
    }

    try {
      final detail = await _remote.getNewsDetail(id);
      if (detail != null) {
        final mapped = detail.toEntity();
        _detailCache[id] = mapped;
        return mapped;
      }
    } on ApiException {
      // fallback to mock
    }

    final mock = await _remote.getMockNews();
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

  Future<void> _saveNewsToDisk(
    List<NewsItem> items, {
    String? category,
    String? keyword,
    int page = 1,
    int limit = AppConstants.pageSize,
  }) async {
    final key = _diskKey(
      category: category,
      keyword: keyword,
      page: page,
      limit: limit,
    );
    await _diskCache.writeMapList(key, items.map(_newsToMap).toList());
  }

  Map<String, dynamic> _newsToMap(NewsItem item) {
    return <String, dynamic>{
      'id': item.id,
      'title': item.title,
      'summary': item.summary,
      'content': item.content,
      'contentType': item.contentType,
      'thumbnailUrl': item.thumbnailUrl,
      'imageUrls': item.imageUrls,
      'categoryName': item.categoryName,
      'publishedAt': item.publishedAt,
    };
  }

  NewsItem _newsFromMap(Map<String, dynamic> map) {
    final imageUrls = (map['imageUrls'] is List)
        ? (map['imageUrls'] as List).map((e) => '$e').toList()
        : <String>[];
    return NewsItem(
      id: '${map['id'] ?? ''}',
      title: '${map['title'] ?? ''}',
      summary: map['summary']?.toString(),
      content: map['content']?.toString(),
      contentType: map['contentType']?.toString(),
      thumbnailUrl: map['thumbnailUrl']?.toString(),
      imageUrls: imageUrls,
      categoryName: map['categoryName']?.toString(),
      publishedAt: map['publishedAt']?.toString(),
    );
  }
}

final newsRemoteDataSourceProvider = Provider<NewsRemoteDataSource>((ref) {
  return NewsRemoteDataSource(ref.watch(apiClientProvider));
});

final newsRepositoryProvider = Provider<NewsRepository>((ref) {
  return NewsRepositoryImpl(
    ref.watch(newsRemoteDataSourceProvider),
    ref.watch(hiveCacheServiceProvider),
  );
});
