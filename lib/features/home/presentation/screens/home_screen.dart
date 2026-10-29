import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../core/widgets/app_empty_state.dart';
import '../../../../core/widgets/app_error_state.dart';
import '../../../../core/widgets/app_header.dart';
import '../../../../core/widgets/app_skeleton.dart';
import '../../../../core/widgets/section_header.dart';
import '../../../news/presentation/widgets/news_card.dart';
import '../../../videos/presentation/widgets/video_card.dart';
import '../providers/home_providers.dart';
import '../widgets/featured_place_tile.dart';
import '../widgets/home_banner_carousel.dart';
import '../widgets/quick_category_tile.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeAsync = ref.watch(homeDataProvider);

    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => ref.refresh(homeDataProvider.future),
          child: homeAsync.when(
            loading: () => const _HomeLoadingView(),
            error: (error, stackTrace) => AppErrorState(
              message: 'Không thể tải dữ liệu trang chủ. Vui lòng thử lại.',
              onRetry: () => ref.invalidate(homeDataProvider),
            ),
            data: (data) {
              if (data.banners.isEmpty &&
                  data.featuredPlaces.isEmpty &&
                  data.latestNews.isEmpty) {
                return AppEmptyState(
                  title: 'Chưa có nội dung',
                  description: 'Dữ liệu du lịch sẽ sớm được cập nhật.',
                  onRetry: () => ref.invalidate(homeDataProvider),
                );
              }

              return ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  AppHeader(
                    title: 'Du lịch Hưng Yên',
                    subtitle: 'Khám phá điểm đến, ẩm thực và câu chuyện địa phương.',
                    leading: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: AppColors.primarySoft,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: Image.asset(
                          'assets/images/app_logo.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    trailing: IconButton.filledTonal(
                      onPressed: () => context.push('/search'),
                      icon: const Icon(Icons.search_rounded),
                    ),
                  ),
                  // const SizedBox(height: 18),
                  // Container(
                  //   padding: const EdgeInsets.all(18),
                  //   decoration: BoxDecoration(
                  //     color: AppColors.primary,
                  //     borderRadius: BorderRadius.circular(30),
                  //   ),
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       Text(
                  //         'Lịch trình cảm hứng cho cuối tuần',
                  //         style: AppTextStyles.hero.copyWith(
                  //           color: Colors.white,
                  //           fontSize: 28,
                  //         ),
                  //       ),
                  //       const SizedBox(height: 8),
                  //       Text(
                  //         'Chọn một hành trình nhanh qua phố cổ, làng nghề, ẩm thực và không gian ven sông.',
                  //         style: AppTextStyles.body.copyWith(
                  //           color: Colors.white.withValues(alpha: 0.88),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  const SizedBox(height: 18),
                  if (data.banners.isNotEmpty) HomeBannerCarousel(banners: data.banners),
                  const SizedBox(height: 24),
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 1.04,
                    children: [
                      QuickCategoryTile(
                        title: 'Đi đâu',
                        icon: Icons.place_outlined,
                        color: const Color(0xFFD7F0EE),
                        accentColor: AppColors.primary,
                        imagePath: 'img/didau.jpg',
                        onTap: () => context.push('/places?type=destination&title=Đi đâu'),
                      ),
                      QuickCategoryTile(
                        title: 'Ăn gì',
                        icon: Icons.restaurant_menu_rounded,
                        color: const Color(0xFFFFE7D1),
                        accentColor: const Color(0xFFB96B20),
                        imagePath: 'img/angi.jpg',
                        onTap: () => context.push('/places?type=food&title=Ăn gì'),
                      ),
                      QuickCategoryTile(
                        title: 'Ở đâu',
                        icon: Icons.hotel_outlined,
                        color: const Color(0xFFE2F1DF),
                        accentColor: const Color(0xFF356949),
                        imagePath: 'img/odau.jpg',
                        onTap: () => context.push('/places?type=stay&title=Ở đâu'),
                      ),
                      QuickCategoryTile(
                        title: 'Di chuyển',
                        icon: Icons.directions_bus_outlined,
                        color: const Color(0xFFFFF0CF),
                        accentColor: const Color(0xFF9A6400),
                        imagePath: 'img/dichuyen.jpg',
                        onTap: () =>
                            context.push('/places?type=transport&title=Di chuyển'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 28),
                  SectionHeader(
                    title: 'Video giới thiệu',
                    actionText: 'Xem tất cả',
                    onActionTap: () => context.go('/videos'),
                  ),
                  const SizedBox(height: 12),
                  VideoCard(
                    videoId: '9jlaBm-L43w',
                    title: 'Video giới thiệu du lịch Hưng Yên',
                    onTap: () => context.push(
                      '/videos/9jlaBm-L43w?title=Video giới thiệu du lịch Hưng Yên',
                    ),
                  ),
                  const SizedBox(height: 28),
                  SectionHeader(
                    title: 'Điểm đến nổi bật',
                    actionText: 'Xem tất cả',
                    onActionTap: () => context.push('/explore'),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 246,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: data.featuredPlaces.length,
                      separatorBuilder: (_, index) => const SizedBox(width: 12),
                      itemBuilder: (_, index) =>
                          FeaturedPlaceTile(place: data.featuredPlaces[index]),
                    ),
                  ),
                  const SizedBox(height: 28),
                  SectionHeader(
                    title: 'Tin tức và sự kiện',
                    actionText: 'Xem tất cả',
                    onActionTap: () => context.go('/news'),
                  ),
                  const SizedBox(height: 12),
                  if (data.latestNews.isNotEmpty) ...[
                    NewsCard(news: data.latestNews.first, featured: true),
                    const SizedBox(height: 12),
                    ...data.latestNews.skip(1).take(3).map(
                          (item) => Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: NewsCard(news: item),
                          ),
                        ),
                  ],
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _HomeLoadingView extends StatelessWidget {
  const _HomeLoadingView();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        AppSkeleton(height: 92, radius: 30),
        SizedBox(height: 18),
        AppSkeleton(height: 150, radius: 30),
        SizedBox(height: 18),
        AppSkeleton(height: 214, radius: 30),
        SizedBox(height: 24),
        AppSkeleton(height: 220, radius: 30),
      ],
    );
  }
}
