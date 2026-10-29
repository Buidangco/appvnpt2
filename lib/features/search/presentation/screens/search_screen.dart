import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/theme/app_text_styles.dart';
import '../../../../core/widgets/app_empty_state.dart';
import '../../../../core/widgets/app_error_state.dart';
import '../../../../core/widgets/app_search_bar.dart';
import '../../../contacts/presentation/widgets/contact_card.dart';
import '../../../news/presentation/widgets/news_card.dart';
import '../../../places/presentation/widgets/place_card.dart';
import '../providers/search_providers.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  Timer? _debounce;
  String _keyword = '';

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _onChanged(String value) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 400), () {
      if (!mounted) return;
      setState(() => _keyword = value.trim());
    });
  }

  @override
  Widget build(BuildContext context) {
    final searchAsync = ref.watch(globalSearchProvider(_keyword));

    return Scaffold(
      appBar: AppBar(title: const Text('Tìm kiếm')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          AppSearchBar(
            controller: _controller,
            hintText: 'Tìm địa điểm, tin tức, liên hệ',
            onChanged: _onChanged,
          ),
          const SizedBox(height: 16),
          if (_keyword.isEmpty)
            const AppEmptyState(
              title: 'Nhập từ khóa để bắt đầu',
              description: 'Ví dụ: Phố Hiến, làng nghề, tin du lịch...',
            )
          else
            searchAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stackTrace) => AppErrorState(
                message: 'Không thể tìm kiếm lúc này.',
                onRetry: () => ref.invalidate(globalSearchProvider),
              ),
              data: (result) {
                if (result.isEmpty) {
                  return const AppEmptyState(
                    title: 'Không có kết quả',
                    description: 'Không tìm thấy dữ liệu phù hợp với từ khóa.',
                  );
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (result.places.isNotEmpty) ...[
                      const Text('Địa điểm', style: AppTextStyles.sectionTitle),
                      const SizedBox(height: 10),
                      ...result.places.take(4).map(
                            (item) => Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: PlaceCard(place: item, compact: true),
                            ),
                          ),
                    ],
                    if (result.news.isNotEmpty) ...[
                      const SizedBox(height: 10),
                      const Text('Tin tức', style: AppTextStyles.sectionTitle),
                      const SizedBox(height: 10),
                      ...result.news.take(4).map(
                            (item) => Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: NewsCard(news: item),
                            ),
                          ),
                    ],
                    if (result.contacts.isNotEmpty) ...[
                      const SizedBox(height: 10),
                      const Text('Liên hệ', style: AppTextStyles.sectionTitle),
                      const SizedBox(height: 10),
                      ...result.contacts.take(4).map(
                            (item) => Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: ContactCard(contact: item),
                            ),
                          ),
                    ],
                  ],
                );
              },
            ),
        ],
      ),
    );
  }
}
