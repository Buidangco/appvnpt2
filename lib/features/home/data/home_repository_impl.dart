import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_client.dart';
import '../../../core/network/api_exception.dart';
import '../../news/data/news_repository_impl.dart';
import '../../news/domain/entities/news_item.dart';
import '../../news/domain/repositories/news_repository.dart';
import '../../places/data/places_repository_impl.dart';
import '../../places/domain/entities/category.dart';
import '../../places/domain/entities/place.dart';
import '../../places/domain/repositories/places_repository.dart';
import '../domain/entities/home_banner.dart';
import '../domain/entities/home_data.dart';
import '../domain/repositories/home_repository.dart';
import 'home_remote_data_source.dart';
import 'models/banner_model.dart';

class HomeRepositoryImpl implements HomeRepository {
  HomeRepositoryImpl(
    this._remote,
    this._placesRepository,
    this._newsRepository,
  );

  final HomeRemoteDataSource _remote;
  final PlacesRepository _placesRepository;
  final NewsRepository _newsRepository;
  HomeData? _cachedHomeData;
  DateTime? _cachedAt;

  static const Duration _cacheTtl = Duration(minutes: 5);

  @override
  Future<HomeData> getHomeData() async {
    if (_cachedHomeData != null &&
        _cachedAt != null &&
        DateTime.now().difference(_cachedAt!) <= _cacheTtl) {
      return _cachedHomeData!;
    }

    final results = await Future.wait([
      _loadBanners(),
      _placesRepository.getCategories(),
      _placesRepository.getPlaces(),
      // Lay_ds_tin_settop (type=1) — tin nổi bật cho khối "Tin tức và sự kiện"
      _newsRepository.getFeaturedNews(),
    ]);

    final banners = results[0] as List<HomeBanner>;
    final categories = results[1] as List<Category>;
    final places = results[2] as List<Place>;
    final latestNews = results[3] as List<NewsItem>;
    final featuredPlaces = places.where((e) => e.isFeatured).toList();

    final homeData = HomeData(
      banners: banners,
      categories: categories,
      featuredPlaces: featuredPlaces.isNotEmpty
          ? featuredPlaces
          : places.take(10).toList(),
      latestNews: latestNews,
    );
    _cachedHomeData = homeData;
    _cachedAt = DateTime.now();
    return homeData;
  }

  Future<List<HomeBanner>> _loadBanners() async {
    try {
      final remote = await _remote.getBanners();
      if (remote.isNotEmpty) {
        return remote.map((e) => e.toEntity()).toList();
      }
    } on ApiException {
      // fallback to mock
    }

    final mock = await _remote.getMockBanners();
    return mock.map((e) => e.toEntity()).toList();
  }
}

final homeRemoteDataSourceProvider = Provider<HomeRemoteDataSource>((ref) {
  return HomeRemoteDataSource(ref.watch(apiClientProvider));
});

final homeRepositoryProvider = Provider<HomeRepository>((ref) {
  return HomeRepositoryImpl(
    ref.watch(homeRemoteDataSourceProvider),
    ref.watch(placesRepositoryProvider),
    ref.watch(newsRepositoryProvider),
  );
});
