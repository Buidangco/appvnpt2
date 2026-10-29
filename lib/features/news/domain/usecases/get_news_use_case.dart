import '../entities/news_item.dart';
import '../repositories/news_repository.dart';

class GetNewsUseCase {
  const GetNewsUseCase(this._repository);

  final NewsRepository _repository;

  Future<List<NewsItem>> call({
    String? category,
    String? keyword,
    int page = 1,
    int limit = 20,
  }) {
    return _repository.getNews(
      category: category,
      keyword: keyword,
      page: page,
      limit: limit,
    );
  }
}
