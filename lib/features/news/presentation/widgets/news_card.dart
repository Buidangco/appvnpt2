import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../core/utils/date_utils.dart';
import '../../../../core/widgets/cached_image.dart';
import '../../domain/entities/news_item.dart';

class NewsCard extends StatelessWidget {
  const NewsCard({super.key, required this.news, this.featured = false});

  final NewsItem news;
  final bool featured;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(28),
        onTap: () => context.push('/news/${news.id}'),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: featured ? _FeaturedNewsCard(news: news) : _CompactNewsCard(news: news),
        ),
      ),
    );
  }
}

class _FeaturedNewsCard extends StatelessWidget {
  const _FeaturedNewsCard({required this.news});

  final NewsItem news;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CachedImage(
          imageUrl: news.thumbnailUrl,
          height: 220,
          width: double.infinity,
          borderRadius: 22,
        ),
        const SizedBox(height: 14),
        _NewsMeta(news: news),
        const SizedBox(height: 10),
        Text(
          news.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyles.titleLarge.copyWith(fontSize: 22),
        ),
        if ((news.summary ?? '').isNotEmpty) ...[
          const SizedBox(height: 8),
          Text(
            news.summary!,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.body.copyWith(color: AppColors.textSecondary),
          ),
        ],
      ],
    );
  }
}

class _CompactNewsCard extends StatelessWidget {
  const _CompactNewsCard({required this.news});

  final NewsItem news;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CachedImage(
          imageUrl: news.thumbnailUrl,
          height: 108,
          width: 118,
          borderRadius: 18,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _NewsMeta(news: news),
              const SizedBox(height: 8),
              Text(
                news.title,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.cardTitle,
              ),
              if ((news.summary ?? '').isNotEmpty) ...[
                const SizedBox(height: 6),
                Text(
                  news.summary!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.meta,
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _NewsMeta extends StatelessWidget {
  const _NewsMeta({required this.news});

  final NewsItem news;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.primarySoft,
            borderRadius: BorderRadius.circular(999),
          ),
          child: Text(
            news.categoryName ?? 'Tin tức',
            style: AppTextStyles.caption.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Text(formatDate(news.publishedAt), style: AppTextStyles.caption),
      ],
    );
  }
}
