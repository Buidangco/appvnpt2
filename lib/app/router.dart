import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../features/contacts/presentation/screens/contacts_screen.dart';
import '../features/home/presentation/screens/home_screen.dart';
import '../features/news/presentation/screens/news_detail_screen.dart';
import '../features/news/presentation/screens/news_screen.dart';
import '../features/places/presentation/screens/explore_screen.dart';
import '../features/places/presentation/screens/place_detail_screen.dart';
import '../features/places/presentation/screens/place_list_screen.dart';
import '../features/search/presentation/screens/search_screen.dart';
import '../features/videos/presentation/screens/video_player_screen.dart';
import '../features/videos/presentation/screens/videos_screen.dart';
import 'main_shell_screen.dart';
import 'menu_screen.dart';
import 'splash_screen.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(path: '/', builder: (context, state) => const SplashScreen()),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainShellScreen(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/home',
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/videos',
                builder: (context, state) => const VideosScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/explore',
                builder: (context, state) => const ExploreScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/news',
                builder: (context, state) => const NewsScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/contacts',
                builder: (context, state) => const ContactsScreen(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: '/search',
        builder: (context, state) => const SearchScreen(),
      ),
      GoRoute(
        path: '/menu',
        builder: (context, state) => const MenuScreen(),
      ),
      GoRoute(
        path: '/places',
        builder: (context, state) {
          final type = state.uri.queryParameters['type'];
          final title = state.uri.queryParameters['title'] ?? 'Địa điểm';
          return PlaceListScreen(type: type, title: title);
        },
      ),
      GoRoute(
        path: '/places/:id',
        builder: (context, state) =>
            PlaceDetailScreen(id: state.pathParameters['id']!),
      ),
      GoRoute(
        path: '/news/:id',
        builder: (context, state) =>
            NewsDetailScreen(id: state.pathParameters['id']!),
      ),
      GoRoute(
        path: '/videos/:id',
        builder: (context, state) => VideoPlayerScreen(
          videoId: state.pathParameters['id']!,
          title: state.uri.queryParameters['title'],
        ),
      ),
    ],
  );
});
