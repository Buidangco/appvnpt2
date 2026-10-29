import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../contacts/data/contacts_repository_impl.dart';
import '../../../news/data/news_repository_impl.dart';
import '../../../places/data/places_repository_impl.dart';
import '../../domain/search_result.dart';

final globalSearchProvider = FutureProvider.family<SearchResult, String>((
  ref,
  keyword,
) async {
  final k = keyword.trim();
  if (k.isEmpty) {
    return const SearchResult();
  }

  final placesFuture = ref
      .watch(placesRepositoryProvider)
      .getPlaces(keyword: k);
  final newsFuture = ref.watch(newsRepositoryProvider).getNews(keyword: k);
  final contactsFuture = ref
      .watch(contactsRepositoryProvider)
      .getContacts(keyword: k);

  final places = await placesFuture;
  final news = await newsFuture;
  final contacts = await contactsFuture;

  return SearchResult(places: places, news: news, contacts: contacts);
});
