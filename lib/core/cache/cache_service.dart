import 'package:shared_preferences/shared_preferences.dart';

class CacheService {
  CacheService(this._prefs);

  final SharedPreferences _prefs;

  static const String favoritePlaceIdsKey = 'favorite_place_ids';

  List<String> getFavoritePlaceIds() {
    return _prefs.getStringList(favoritePlaceIdsKey) ?? <String>[];
  }

  Future<void> saveFavoritePlaceIds(List<String> ids) async {
    await _prefs.setStringList(favoritePlaceIdsKey, ids);
  }
}
