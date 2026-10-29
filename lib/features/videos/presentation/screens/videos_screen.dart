import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/widgets/app_header.dart';
import '../widgets/video_card.dart';

class _VideoItem {
  const _VideoItem({required this.id, required this.title});

  final String id;
  final String title;
}

/// Danh sách "Video nổi bật" lấy từ trang chủ hungyentourism.com.vn
/// (trang không có API riêng cho video, chỉ nhúng tĩnh danh sách YouTube).
const _videos = [
  _VideoItem(id: '9jlaBm-L43w', title: 'Khám phá lễ hội Chùa Keo Hưng Yên'),
  _VideoItem(id: 'TTW7eZfEmCI', title: 'Một thoáng làng Nôm'),
  _VideoItem(id: '5XkMocmUwZQ', title: 'Hưng Yên - Điểm đến hấp dẫn của du khách'),
  _VideoItem(id: 'jpMQgawmF4Q', title: 'Đặc sắc Lễ hội truyền thống Hưng Yên'),
  _VideoItem(id: 'oq3iqoueKK0', title: 'Nét đẹp văn hoá Phố Hiến'),
  _VideoItem(id: 'skxZhpj-GcM', title: 'Nét đẹp văn hóa làng cổ Đại Đồng'),
];

const _pageSize = 3;

class VideosScreen extends StatefulWidget {
  const VideosScreen({super.key});

  @override
  State<VideosScreen> createState() => _VideosScreenState();
}

class _VideosScreenState extends State<VideosScreen> {
  final _scrollController = ScrollController();
  int _visibleCount = _pageSize;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_visibleCount >= _videos.length) return;
    final remain = _scrollController.position.maxScrollExtent -
        _scrollController.position.pixels;
    if (remain <= 200) {
      setState(() {
        _visibleCount = (_visibleCount + _pageSize).clamp(0, _videos.length);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final visibleVideos = _videos.take(_visibleCount).toList();
    final hasMore = _visibleCount < _videos.length;

    return Scaffold(
      body: SafeArea(
        child: ListView(
          controller: _scrollController,
          padding: const EdgeInsets.all(16),
          children: [
            const AppHeader(
              title: 'Video',
              subtitle: 'Những thước phim giới thiệu du lịch Hưng Yên.',
            ),
            const SizedBox(height: 18),
            ...visibleVideos.map(
              (video) => Padding(
                padding: const EdgeInsets.only(bottom: 14),
                child: VideoCard(
                  videoId: video.id,
                  title: video.title,
                  onTap: () => context.push(
                    '/videos/${video.id}?title=${Uri.encodeComponent(video.title)}',
                  ),
                ),
              ),
            ),
            if (hasMore)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Center(child: CircularProgressIndicator()),
              ),
          ],
        ),
      ),
    );
  }
}
