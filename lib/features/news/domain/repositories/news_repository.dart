import '../entities/news_item.dart';

abstract class NewsRepository {
  Future<List<NewsItem>> getNews({
    String? category,
    String? keyword,
    int page,
    int limit,
  });

  Future<List<NewsItem>> getFeaturedNews();

  Future<NewsItem?> getNewsDetail(String id);
}
