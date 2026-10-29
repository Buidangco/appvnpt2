import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/widgets/app_empty_state.dart';
import '../../../../core/widgets/app_error_state.dart';
import '../../../../core/widgets/app_search_bar.dart';
import '../providers/places_providers.dart';
import '../widgets/place_card.dart';

class PlaceListScreen extends ConsumerStatefulWidget {
  const PlaceListScreen({super.key, required this.type, required this.title});

  final String? type;
  final String title;

  @override
  ConsumerState<PlaceListScreen> createState() => _PlaceListScreenState();
}

class _PlaceListScreenState extends ConsumerState<PlaceListScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final placesAsync = ref.watch(
      placesProvider(
        PlacesQuery(type: widget.type, keyword: _searchController.text),
      ),
    );

    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(placesProvider);
        },
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            AppSearchBar(
              controller: _searchController,
              hintText: 'Tìm trong ${widget.title.toLowerCase()}',
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 16),
            placesAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, _) => AppErrorState(
                message: 'Không thể tải danh sách.',
                onRetry: () => ref.invalidate(placesProvider),
              ),
              data: (places) {
                if (places.isEmpty) {
                  return AppEmptyState(
                    title: 'Không có dữ liệu',
                    description: 'Không có địa điểm phù hợp với từ khóa hiện tại.',
                    onRetry: () => ref.invalidate(placesProvider),
                  );
                }
                return ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: places.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 12),
                  itemBuilder: (_, index) => PlaceCard(place: places[index]),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
