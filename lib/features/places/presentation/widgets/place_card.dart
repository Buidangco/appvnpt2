import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../core/utils/map_utils.dart';
import '../../../../core/utils/phone_utils.dart';
import '../../../../core/widgets/cached_image.dart';
import '../../domain/entities/place.dart';

class PlaceCard extends StatelessWidget {
  const PlaceCard({super.key, required this.place, this.compact = false});

  final Place place;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(28),
        onTap: () => context.push('/places/${place.id}'),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: compact ? _CompactPlaceCard(place: place) : _FullPlaceCard(place: place),
        ),
      ),
    );
  }
}

class _CompactPlaceCard extends StatelessWidget {
  const _CompactPlaceCard({required this.place});

  final Place place;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CachedImage(
          imageUrl: place.thumbnailUrl,
          height: 108,
          width: 118,
          borderRadius: 18,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(place.name, maxLines: 2, overflow: TextOverflow.ellipsis, style: AppTextStyles.cardTitle),
              const SizedBox(height: 6),
              Text(
                place.address ?? 'Chưa cập nhật địa chỉ',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.meta,
              ),
              const SizedBox(height: 10),
              TextButton.icon(
                onPressed: () => context.push('/places/${place.id}'),
                icon: const Icon(Icons.arrow_outward_rounded, size: 16),
                label: const Text('Khám phá ngay'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _FullPlaceCard extends StatelessWidget {
  const _FullPlaceCard({required this.place});

  final Place place;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CachedImage(
          imageUrl: place.thumbnailUrl,
          height: 192,
          width: double.infinity,
          borderRadius: 22,
        ),
        const SizedBox(height: 14),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            if ((place.districtName ?? '').isNotEmpty)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.surfaceAlt,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(place.districtName!, style: AppTextStyles.caption),
              ),
          ],
        ),
        const SizedBox(height: 8),
        Text(place.name, maxLines: 2, overflow: TextOverflow.ellipsis, style: AppTextStyles.titleLarge.copyWith(fontSize: 21)),
        const SizedBox(height: 6),
        Text(
          place.address ?? 'Chưa cập nhật địa chỉ',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyles.meta,
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            if ((place.phone ?? '').isNotEmpty)
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => launchPhoneCall(place.phone!),
                  icon: const Icon(Icons.call_outlined),
                  label: const Text('Gọi'),
                ),
              ),
            if ((place.phone ?? '').isNotEmpty) const SizedBox(width: 10),
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () => launchMap(
                  latitude: place.latitude,
                  longitude: place.longitude,
                  address: place.address,
                ),
                icon: const Icon(Icons.map_outlined),
                label: const Text('Chỉ đường'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
