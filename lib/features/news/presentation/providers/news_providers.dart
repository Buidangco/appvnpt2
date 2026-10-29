import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/news_repository_impl.dart';
import '../../domain/entities/news_item.dart';

class NewsQuery {
  const NewsQuery({
    this.category = 'all',
    this.keyword,
    this.page = 1,
    this.limit = 20,
  });

  final String category;
  final String? keyword;
  final int page;
  final int limit;

  @override
  bool operator ==(Object other) {
    return other is NewsQuery &&
        other.category == category &&
        other.keyword == keyword &&
        other.page == page &&
        other.limit == limit;
  }

  @override
  int get hashCode => Object.hash(category, keyword, page, limit);
}

final newsProvider = StreamProvider.family<List<NewsItem>, NewsQuery>((
  ref,
  query,
) async* {
  final repo = ref.watch(newsRepositoryProvider);
  final impl = repo is NewsRepositoryImpl ? repo : null;

  if (impl != null) {
    final cached = impl.getCachedNews(
      category: query.category,
      keyword: query.keyword,
      page: query.page,
      limit: query.limit,
    );
    if (cached.isNotEmpty) {
      yield cached;
    }

    try {
      final fresh = await impl.fetchFreshNews(
        category: query.category,
        keyword: query.keyword,
        page: query.page,
        limit: query.limit,
      );
      debugPrint('[NEWS] fetchFreshNews → ${fresh.length} items');
      yield fresh;
      return;
    } catch (e, st) {
      debugPrint('[NEWS] fetchFreshNews ERROR: $e');
      debugPrint('[NEWS] stacktrace: $st');
      if (cached.isNotEmpty) {
        return;
      }
    }
  }

  try {
    final data = await repo.getNews(
      category: query.category,
      keyword: query.keyword,
      page: query.page,
      limit: query.limit,
    );
    debugPrint('[NEWS] getNews → ${data.length} items');
    yield data;
  } catch (e, st) {
    debugPrint('[NEWS] getNews ERROR: $e');
    debugPrint('[NEWS] stacktrace: $st');
    yield const <NewsItem>[];
  }
});

final newsDetailProvider = FutureProvider.family<NewsItem?, String>((ref, id) {
  return ref.watch(newsRepositoryProvider).getNewsDetail(id);
});
