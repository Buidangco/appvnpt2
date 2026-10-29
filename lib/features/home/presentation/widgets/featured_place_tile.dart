import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/theme/app_text_styles.dart';
import '../../../../core/widgets/cached_image.dart';
import '../../../places/domain/entities/place.dart';

class FeaturedPlaceTile extends StatelessWidget {
  const FeaturedPlaceTile({super.key, required this.place});

  final Place place;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 240,
      child: Card(
        child: InkWell(
          borderRadius: BorderRadius.circular(28),
          onTap: () => context.push('/places/${place.id}'),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CachedImage(
                  imageUrl: place.thumbnailUrl,
                  height: 132,
                  width: double.infinity,
                  borderRadius: 20,
                ),
                const SizedBox(height: 12),
                Text(
                  place.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.cardTitle,
                ),
                const SizedBox(height: 6),
                Text(
                  place.districtName ?? 'Hưng Yên',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.meta,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
