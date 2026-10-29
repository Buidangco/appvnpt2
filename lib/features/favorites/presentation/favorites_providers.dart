import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/cache/cache_providers.dart';

class FavoritesNotifier extends StateNotifier<Set<String>> {
  FavoritesNotifier() : super(<String>{});

  void setAll(List<String> ids) {
    state = ids.toSet();
  }

  Future<void> toggle(String id, WidgetRef ref) async {
    final next = {...state};
    if (next.contains(id)) {
      next.remove(id);
    } else {
      next.add(id);
    }
    state = next;

    final cache = ref.read(cacheServiceProvider);
    if (cache != null) {
      await cache.saveFavoritePlaceIds(next.toList());
    }
  }
}

final favoritesProvider = StateNotifierProvider<FavoritesNotifier, Set<String>>(
  (ref) {
    final notifier = FavoritesNotifier();
    ref.listen(sharedPreferencesProvider, (_, next) {
      final prefs = next.valueOrNull;
      if (prefs != null) {
        notifier.setAll(
          prefs.getStringList('favorite_place_ids') ?? <String>[],
        );
      }
    });
    return notifier;
  },
);
