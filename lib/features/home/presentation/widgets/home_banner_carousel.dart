import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../core/widgets/cached_image.dart';
import '../../domain/entities/home_banner.dart';

class HomeBannerCarousel extends StatefulWidget {
  const HomeBannerCarousel({super.key, required this.banners});

  final List<HomeBanner> banners;

  @override
  State<HomeBannerCarousel> createState() => _HomeBannerCarouselState();
}

class _HomeBannerCarouselState extends State<HomeBannerCarousel> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: widget.banners.length,
          itemBuilder: (context, index, _) {
            final banner = widget.banners[index];
            return Stack(
              fit: StackFit.expand,
              children: [
                CachedImage(
                  imageUrl: banner.imageUrl,
                  height: 210,
                  width: double.infinity,
                  borderRadius: 30,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    gradient: const LinearGradient(
                      colors: [Color(0x0D000000), Color(0xB3000000)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
                Positioned(
                  left: 20,
                  right: 20,
                  bottom: 20,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: AppColors.accentSoft.withValues(alpha: 0.92),
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: const Text('Điểm nhấn hôm nay', style: AppTextStyles.caption),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        banner.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.hero.copyWith(color: Colors.white, fontSize: 26),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
          options: CarouselOptions(
            height: 214,
            viewportFraction: 1,
            autoPlay: true,
            onPageChanged: (index, _) => setState(() => _index = index),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(widget.banners.length, (i) {
            final selected = i == _index;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: selected ? 24 : 8,
              height: 8,
              decoration: BoxDecoration(
                color: selected ? AppColors.primary : AppColors.border,
                borderRadius: BorderRadius.circular(999),
              ),
            );
          }),
        ),
      ],
    );
  }
}
