import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/places_repository_impl.dart';
import '../../domain/entities/category.dart';
import '../../domain/entities/district.dart';
import '../../domain/entities/place.dart';

class PlacesQuery {
  const PlacesQuery({
    this.type,
    this.districtId,
    this.keyword,
    this.page = 1,
    this.limit = 20,
  });

  final String? type;
  final String? districtId;
  final String? keyword;
  final int page;
  final int limit;

  @override
  bool operator ==(Object other) {
    return other is PlacesQuery &&
        other.type == type &&
        other.districtId == districtId &&
        other.keyword == keyword &&
        other.page == page &&
        other.limit == limit;
  }

  @override
  int get hashCode => Object.hash(type, districtId, keyword, page, limit);
}

final placesProvider = StreamProvider.family<List<Place>, PlacesQuery>((
  ref,
  query,
) async* {
  final repo = ref.watch(placesRepositoryProvider);
  final impl = repo is PlacesRepositoryImpl ? repo : null;

  if (impl != null) {
    final cached = impl.getCachedPlaces(
      type: query.type,
      districtId: query.districtId,
      keyword: query.keyword,
      page: query.page,
      limit: query.limit,
    );
    if (cached.isNotEmpty) {
      yield cached;
    }

    try {
      final fresh = await impl.fetchFreshPlaces(
        type: query.type,
        districtId: query.districtId,
        keyword: query.keyword,
        page: query.page,
        limit: query.limit,
      );
      yield fresh;
      return;
    } catch (_) {
      if (cached.isNotEmpty) {
        return;
      }
    }
  }

  final data = await repo.getPlaces(
    type: query.type,
    districtId: query.districtId,
    keyword: query.keyword,
    page: query.page,
    limit: query.limit,
  );
  yield data;
});

final placeDetailProvider = FutureProvider.family<Place?, String>((ref, id) {
  return ref.watch(placesRepositoryProvider).getPlaceDetail(id);
});

final districtsProvider = FutureProvider<List<District>>((ref) {
  return ref.watch(placesRepositoryProvider).getDistricts();
});

final categoriesProvider = FutureProvider<List<Category>>((ref) {
  return ref.watch(placesRepositoryProvider).getCategories();
});
