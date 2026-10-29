import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../core/widgets/cached_image.dart';

class VideoCard extends StatelessWidget {
  const VideoCard({
    super.key,
    required this.videoId,
    required this.title,
    required this.onTap,
  });

  final String videoId;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: Stack(
          alignment: Alignment.center,
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: CachedImage(
                imageUrl: 'https://img.youtube.com/vi/$videoId/hqdefault.jpg',
                width: double.infinity,
                fit: BoxFit.cover,
                borderRadius: 0,
              ),
            ),
            Container(color: Colors.black.withValues(alpha: 0.18)),
            Container(
              width: 64,
              height: 64,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.play_arrow_rounded,
                color: AppColors.primary,
                size: 36,
              ),
            ),
            Positioned(
              left: 16,
              right: 16,
              bottom: 14,
              child: Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.cardTitle.copyWith(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
