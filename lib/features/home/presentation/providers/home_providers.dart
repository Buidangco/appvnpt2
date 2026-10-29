import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/home_repository_impl.dart';
import '../../domain/entities/home_data.dart';

final homeDataProvider = FutureProvider<HomeData>((ref) {
  return ref.watch(homeRepositoryProvider).getHomeData();
});
