import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/news_repository_impl.dart';
import '../../domain/entities/news_item.dart';

class NewsFeedState {
  const NewsFeedState({
    this.items = const <NewsItem>[],
    this.page = 0,
    this.isInitialLoading = false,
    this.isLoadingMore = false,
    this.hasMore = true,
    this.error,
    this.loadMoreError,
  });

  final List<NewsItem> items;
  final int page;
  final bool isInitialLoading;
  final bool isLoadingMore;
  final bool hasMore;
  final String? error;
  final String? loadMoreError;

  NewsFeedState copyWith({
    List<NewsItem>? items,
    int? page,
    bool? isInitialLoading,
    bool? isLoadingMore,
    bool? hasMore,
    String? error,
    String? loadMoreError,
    bool clearError = false,
    bool clearLoadMoreError = false,
  }) {
    return NewsFeedState(
      items: items ?? this.items,
      page: page ?? this.page,
      isInitialLoading: isInitialLoading ?? this.isInitialLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasMore: hasMore ?? this.hasMore,
      error: clearError ? null : (error ?? this.error),
      loadMoreError: clearLoadMoreError
          ? null
          : (loadMoreError ?? this.loadMoreError),
    );
  }
}

class NewsFeedController extends StateNotifier<NewsFeedState> {
  NewsFeedController(this._repository) : super(const NewsFeedState());

  final NewsRepositoryImpl _repository;
  static const int _backendPageSize = 15;

  Future<void> loadInitial() async {
    if (state.isInitialLoading) return;

    state = state.copyWith(
      isInitialLoading: true,
      isLoadingMore: false,
      hasMore: true,
      items: const <NewsItem>[],
      page: 0,
      clearError: true,
      clearLoadMoreError: true,
    );

    try {
      final items = await _repository.fetchFreshNews(
        page: 1,
        limit: _backendPageSize,
      );
      state = state.copyWith(
        items: _dedupe(items),
        page: 1,
        isInitialLoading: false,
        hasMore: items.length >= _backendPageSize,
        clearError: true,
      );
    } catch (_) {
      final fallback = await _repository.getNews(
        page: 1,
        limit: _backendPageSize,
      );
      state = state.copyWith(
        items: _dedupe(fallback),
        page: fallback.isEmpty ? 0 : 1,
        isInitialLoading: false,
        hasMore: fallback.length >= _backendPageSize,
        error: fallback.isEmpty ? 'Không thể tải tin tức.' : null,
        clearError: fallback.isNotEmpty,
      );
    }
  }

  Future<void> refresh() => loadInitial();

  Future<void> loadMore() async {
    if (state.isInitialLoading || state.isLoadingMore || !state.hasMore) return;

    final nextPage = state.page + 1;
    state = state.copyWith(
      isLoadingMore: true,
      clearLoadMoreError: true,
    );

    try {
      final nextItems = await _repository.fetchFreshNews(
        page: nextPage,
        limit: _backendPageSize,
      );
      final merged = _dedupe(<NewsItem>[...state.items, ...nextItems]);
      state = state.copyWith(
        items: merged,
        page: nextPage,
        isLoadingMore: false,
        hasMore: nextItems.length >= _backendPageSize,
        clearLoadMoreError: true,
      );
    } catch (_) {
      final fallback = await _repository.getNews(
        page: nextPage,
        limit: _backendPageSize,
      );
      if (fallback.isNotEmpty) {
        final merged = _dedupe(<NewsItem>[...state.items, ...fallback]);
        state = state.copyWith(
          items: merged,
          page: nextPage,
          isLoadingMore: false,
          hasMore: fallback.length >= _backendPageSize,
          clearLoadMoreError: true,
        );
        return;
      }

      state = state.copyWith(
        isLoadingMore: false,
        loadMoreError: 'Không thể tải thêm tin tức.',
      );
    }
  }

  List<NewsItem> _dedupe(List<NewsItem> items) {
    final map = <String, NewsItem>{};
    for (final item in items) {
      map[item.id] = item;
    }
    return map.values.toList();
  }
}

final newsFeedControllerProvider =
    StateNotifierProvider.autoDispose<NewsFeedController, NewsFeedState>((ref) {
      final repository = ref.watch(newsRepositoryProvider);
      final impl = repository as NewsRepositoryImpl;
      return NewsFeedController(impl);
    });
