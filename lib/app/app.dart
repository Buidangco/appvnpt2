import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'router.dart';
import 'theme/app_theme.dart';

class HungYenTravelApp extends ConsumerWidget {
  const HungYenTravelApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Du lịch Hưng Yên',
      theme: AppTheme.light(),
      routerConfig: router,
    );
  }
}
