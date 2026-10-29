import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/widgets/app_empty_state.dart';
import '../../../../core/widgets/app_error_state.dart';
import '../../../../core/widgets/app_header.dart';
import '../../../../core/widgets/app_search_bar.dart';
import '../../../places/presentation/providers/places_providers.dart';
import '../../../places/presentation/widgets/place_card.dart';

class ExploreScreen extends ConsumerStatefulWidget {
  const ExploreScreen({super.key});

  @override
  ConsumerState<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends ConsumerState<ExploreScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final placesAsync = ref.watch(
      placesProvider(PlacesQuery(keyword: _searchController.text)),
    );

    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            ref.invalidate(placesProvider);
          },
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              const AppHeader(
                title: 'Khám phá',
                subtitle: 'Lướt qua những điểm dừng thú vị nhất cho chuyến đi tiếp theo.',
              ),
              const SizedBox(height: 12),
              AppSearchBar(
                controller: _searchController,
                hintText: 'Tìm địa điểm, ẩm thực, làng nghề...',
                onChanged: (_) => setState(() {}),
              ),
              const SizedBox(height: 18),
              placesAsync.when(
                loading: () => const Padding(
                  padding: EdgeInsets.only(top: 40),
                  child: Center(child: CircularProgressIndicator()),
                ),
                error: (error, _) => AppErrorState(
                  message: 'Không thể tải danh sách địa điểm.',
                  onRetry: () => ref.invalidate(placesProvider),
                ),
                data: (places) {
                  if (places.isEmpty) {
                    return AppEmptyState(
                      title: 'Không tìm thấy địa điểm phù hợp',
                      description: 'Bạn thử thay đổi từ khóa tìm kiếm.',
                      onRetry: () => ref.invalidate(placesProvider),
                    );
                  }
                  return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: places.length,
                    separatorBuilder: (_, index) => const SizedBox(height: 12),
                    itemBuilder: (_, index) => PlaceCard(place: places[index]),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
