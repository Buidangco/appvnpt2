import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/theme/app_text_styles.dart';
import '../../../../core/widgets/app_empty_state.dart';
import '../../../../core/widgets/app_error_state.dart';
import '../../../../core/widgets/app_header.dart';
import '../providers/news_feed_controller.dart';
import '../widgets/news_card.dart';

class NewsScreen extends ConsumerStatefulWidget {
  const NewsScreen({super.key});

  @override
  ConsumerState<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends ConsumerState<NewsScreen> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
    Future.microtask(() {
      final state = ref.read(newsFeedControllerProvider);
      if (state.items.isEmpty && !state.isInitialLoading) {
        ref.read(newsFeedControllerProvider.notifier).loadInitial();
      }
    });
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final remain = _scrollController.position.maxScrollExtent -
        _scrollController.position.pixels;
    if (remain <= 360) {
      ref.read(newsFeedControllerProvider.notifier).loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    final feed = ref.watch(newsFeedControllerProvider);

    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => ref.read(newsFeedControllerProvider.notifier).refresh(),
          child: feed.isInitialLoading && feed.items.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : feed.error != null && feed.items.isEmpty
                  ? AppErrorState(
                      message: feed.error!,
                      onRetry: () =>
                          ref.read(newsFeedControllerProvider.notifier).loadInitial(),
                    )
                  : feed.items.isEmpty
                      ? AppEmptyState(
                          title: 'Chưa có bài viết',
                          description:
                              'Tin tức và sự kiện mới sẽ sớm được cập nhật.',
                          onRetry: () => ref
                              .read(newsFeedControllerProvider.notifier)
                              .loadInitial(),
                        )
                      : CustomScrollView(
                          controller: _scrollController,
                          slivers: [
                            SliverPadding(
                              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                              sliver: SliverToBoxAdapter(
                                child: AppHeader(
                                  title: 'Tin tức',
                                  subtitle:
                                      'Theo dõi câu chuyện, sự kiện và nhịp sống du lịch Hưng Yên.',
                                  trailing: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 10,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SliverPadding(
                              padding: const EdgeInsets.all(16),
                              sliver: SliverList.separated(
                                itemBuilder: (context, index) => NewsCard(
                                  news: feed.items[index],
                                  featured: index == 0,
                                ),
                                separatorBuilder: (_, index) =>
                                    const SizedBox(height: 12),
                                itemCount: feed.items.length,
                              ),
                            ),
                            SliverToBoxAdapter(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                                child: _NewsFooter(feed: feed),
                              ),
                            ),
                          ],
                        ),
        ),
      ),
    );
  }
}

class _NewsFooter extends ConsumerWidget {
  const _NewsFooter({required this.feed});

  final NewsFeedState feed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (feed.isLoadingMore) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (feed.loadMoreError != null) {
      return Center(
        child: TextButton.icon(
          onPressed: () => ref.read(newsFeedControllerProvider.notifier).loadMore(),
          icon: const Icon(Icons.refresh_rounded),
          label: Text(feed.loadMoreError!),
        ),
      );
    }

    if (!feed.hasMore) {
      return Center(
        child: Text(
          'Bạn đã xem hết tin hiện có.',
          style: AppTextStyles.caption,
        ),
      );
    }

    return const SizedBox.shrink();
  }
}
