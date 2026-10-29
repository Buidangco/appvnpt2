import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

const String appCacheBoxName = 'app_cache_box';

class HiveCacheService {
  HiveCacheService(this._box);

  final Box<dynamic> _box;

  List<Map<String, dynamic>> readMapList(String key) {
    final raw = _box.get(key);
    if (raw is! String || raw.isEmpty) {
      return <Map<String, dynamic>>[];
    }
    try {
      final decoded = jsonDecode(raw);
      if (decoded is List) {
        return decoded
            .whereType<Map>()
            .map((e) => Map<String, dynamic>.from(e))
            .toList();
      }
    } catch (_) {
      // ignore cache parse errors
    }
    return <Map<String, dynamic>>[];
  }

  Future<void> writeMapList(String key, List<Map<String, dynamic>> data) async {
    final encoded = jsonEncode(data);
    await _box.put(key, encoded);
  }
}

final hiveBoxProvider = Provider<Box<dynamic>>((ref) {
  return Hive.box<dynamic>(appCacheBoxName);
});

final hiveCacheServiceProvider = Provider<HiveCacheService>((ref) {
  return HiveCacheService(ref.watch(hiveBoxProvider));
});
