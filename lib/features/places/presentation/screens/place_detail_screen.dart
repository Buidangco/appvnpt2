import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../app/theme/app_text_styles.dart';
import '../../../../core/utils/map_utils.dart';
import '../../../../core/utils/phone_utils.dart';
import '../../../../core/widgets/app_empty_state.dart';
import '../../../../core/widgets/app_error_state.dart';
import '../../../../core/widgets/cached_image.dart';
import '../../../../core/widgets/info_row.dart';
import '../../../favorites/presentation/favorites_providers.dart';
import '../providers/places_providers.dart';

class PlaceDetailScreen extends ConsumerWidget {
  const PlaceDetailScreen({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailAsync = ref.watch(placeDetailProvider(id));
    final favorites = ref.watch(favoritesProvider);

    return detailAsync.when(
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (error, _) => Scaffold(
        appBar: AppBar(),
        body: AppErrorState(
          message: 'Không thể tải chi tiết địa điểm.',
          onRetry: () => ref.invalidate(placeDetailProvider(id)),
        ),
      ),
      data: (place) {
        if (place == null) {
          return Scaffold(
            appBar: AppBar(),
            body: const AppEmptyState(
              title: 'Không tìm thấy địa điểm',
              description: 'Dữ liệu có thể đã thay đổi.',
            ),
          );
        }

        final isFavorite = favorites.contains(place.id);
        final description =
            place.description ?? place.shortDescription ?? 'Nội dung đang được cập nhật.';
        final hasHtml = description.contains('<') && description.contains('>');

        return Scaffold(
          bottomNavigationBar: SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: (place.phone ?? '').isEmpty
                          ? null
                          : () => launchPhoneCall(place.phone!),
                      icon: const Icon(Icons.call_outlined),
                      label: const Text('Gọi điện'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => launchMap(
                        latitude: place.latitude,
                        longitude: place.longitude,
                        address: place.address,
                      ),
                      icon: const Icon(Icons.map_outlined),
                      label: const Text('Chỉ đường'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: FilledButton.icon(
                      onPressed: () => SharePlus.instance.share(
                        ShareParams(text: '${place.name} - ${place.address ?? ''}'),
                      ),
                      icon: const Icon(Icons.share_outlined),
                      label: const Text('Chia sẻ'),
                    ),
                  ),
                ],
              ),
            ),
          ),
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: true,
                expandedHeight: 310,
                actions: [
                  IconButton(
                    onPressed: () => ref
                        .read(favoritesProvider.notifier)
                        .toggle(place.id, ref),
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                    ),
                  ),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  background: CachedImage(
                    imageUrl: place.imageUrls.isNotEmpty
                        ? place.imageUrls.first
                        : place.thumbnailUrl,
                    height: 310,
                    width: double.infinity,
                    borderRadius: 0,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(place.name, style: AppTextStyles.hero.copyWith(fontSize: 28)),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          Chip(label: Text(place.categoryName ?? 'Địa điểm')),
                          Chip(label: Text(place.districtName ?? 'Hưng Yên')),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(28),
                        ),
                        child: Column(
                          children: [
                            InfoRow(
                              icon: Icons.place_outlined,
                              label: 'Địa chỉ',
                              value: place.address ?? 'Đang cập nhật',
                            ),
                            const SizedBox(height: 10),
                            InfoRow(
                              icon: Icons.call_outlined,
                              label: 'Số điện thoại',
                              value: (place.phone ?? '').isEmpty
                                  ? 'Đang cập nhật'
                                  : place.phone!,
                            ),
                            const SizedBox(height: 10),
                            InfoRow(
                              icon: Icons.schedule_outlined,
                              label: 'Giờ mở cửa',
                              value: place.openingHours ?? 'Đang cập nhật',
                            ),
                            const SizedBox(height: 10),
                            InfoRow(
                              icon: Icons.location_city_outlined,
                              label: 'Khu vực',
                              value: place.districtName ?? 'Hưng Yên',
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 18),
                      if (hasHtml)
                        Html(
                          data: description,
                          style: {
                            'img': Style(
                              width: Width(100, Unit.percent),
                              height: Height.auto(),
                            ),
                          },
                        )
                      else
                        Text(description, style: AppTextStyles.body),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
