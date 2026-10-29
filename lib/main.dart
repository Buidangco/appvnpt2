import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app/app.dart';
import 'app/env.dart';
import 'core/cache/hive_cache_service.dart';
import 'core/network/tls_http_overrides.dart'
    if (dart.library.io) 'core/network/tls_http_overrides_io.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  installTestTlsHttpOverrides(
    allowBadTlsForTest: Env.allowBadTlsForTest,
    apiBaseUrl: Env.apiBaseUrl,
  );
  await Hive.initFlutter();
  await Hive.openBox<dynamic>(appCacheBoxName);
  runApp(const ProviderScope(child: HungYenTravelApp()));
}
