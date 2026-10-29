import '../../contacts/domain/entities/contact.dart';
import '../../news/domain/entities/news_item.dart';
import '../../places/domain/entities/place.dart';

class SearchResult {
  const SearchResult({
    this.places = const <Place>[],
    this.news = const <NewsItem>[],
    this.contacts = const <Contact>[],
  });

  final List<Place> places;
  final List<NewsItem> news;
  final List<Contact> contacts;

  bool get isEmpty => places.isEmpty && news.isEmpty && contacts.isEmpty;
}
