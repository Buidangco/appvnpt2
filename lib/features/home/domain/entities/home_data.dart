import '../../../news/domain/entities/news_item.dart';
import '../../../places/domain/entities/category.dart';
import '../../../places/domain/entities/place.dart';
import 'home_banner.dart';

class HomeData {
  const HomeData({
    required this.banners,
    required this.categories,
    required this.featuredPlaces,
    required this.latestNews,
  });

  final List<HomeBanner> banners;
  final List<Category> categories;
  final List<Place> featuredPlaces;
  final List<NewsItem> latestNews;
}
