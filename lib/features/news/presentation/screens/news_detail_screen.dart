import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../app/theme/app_text_styles.dart';
import '../../../../core/utils/date_utils.dart';
import '../../../../core/widgets/app_empty_state.dart';
import '../../../../core/widgets/app_error_state.dart';
import '../../../../core/widgets/cached_image.dart';
import '../providers/news_providers.dart';
import '../widgets/news_card.dart';

class NewsDetailScreen extends ConsumerWidget {
  const NewsDetailScreen({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailAsync = ref.watch(newsDetailProvider(id));

    return detailAsync.when(
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (error, stackTrace) => Scaffold(
        appBar: AppBar(),
        body: AppErrorState(
          message: 'Không thể tải nội dung bài viết.',
          onRetry: () => ref.invalidate(newsDetailProvider(id)),
        ),
      ),
      data: (news) {
        if (news == null) {
          return Scaffold(
            appBar: AppBar(),
            body: const AppEmptyState(
              title: 'Không tìm thấy bài viết',
              description: 'Bài viết có thể đã bị thay đổi hoặc xóa.',
            ),
          );
        }

        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                onPressed: () =>
                    SharePlus.instance.share(ShareParams(text: news.title)),
                icon: const Icon(Icons.share_outlined),
              ),
            ],
          ),
          body: ListView(
            padding: const EdgeInsets.fromLTRB(16, 6, 16, 24),
            children: [
              CachedImage(
                imageUrl: news.thumbnailUrl,
                height: 260,
                width: double.infinity,
                borderRadius: 28,
              ),
              const SizedBox(height: 18),
              Text(news.title, style: AppTextStyles.hero.copyWith(fontSize: 28)),
              const SizedBox(height: 12),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  Chip(label: Text(news.categoryName ?? 'Tin tức')),
                  Text(formatDate(news.publishedAt), style: AppTextStyles.meta),
                ],
              ),
              const SizedBox(height: 18),
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(28),
                ),
                child: (news.contentType ?? 'text').toLowerCase().contains('html')
                    ? Html(
                        data: news.content ?? '',
                        style: {
                          'table': Style(width: Width(100, Unit.percent)),
                        },
                        extensions: [
                          TagExtension(
                            tagsToExtend: {'img'},
                            builder: (extensionContext) {
                              final src =
                                  extensionContext.attributes['src'] ?? '';
                              if (src.isEmpty) return const SizedBox.shrink();
                              return LayoutBuilder(
                                builder: (context, constraints) => Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 8,
                                  ),
                                  child: CachedImage(
                                    imageUrl: src,
                                    width: constraints.maxWidth,
                                    fit: BoxFit.contain,
                                    borderRadius: 12,
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      )
                    : Text(
                        news.content ?? news.summary ?? 'Nội dung đang cập nhật.',
                        style: AppTextStyles.body,
                      ),
              ),
              const SizedBox(height: 24),
              const Text('Tin liên quan', style: AppTextStyles.sectionTitle),
              const SizedBox(height: 10),
              Consumer(
                builder: (context, ref, _) {
                  final relatedAsync = ref.watch(newsProvider(const NewsQuery()));
                  return relatedAsync.when(
                    loading: () => const SizedBox.shrink(),
                    error: (error, stackTrace) => const SizedBox.shrink(),
                    data: (items) {
                      final related =
                          items.where((e) => e.id != news.id).take(3).toList();
                      return Column(
                        children: related
                            .map(
                              (item) => Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: NewsCard(news: item),
                              ),
                            )
                            .toList(),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
