import 'package:flutter/material.dart';

import '../../../../app/theme/app_text_styles.dart';

class QuickCategoryTile extends StatelessWidget {
  const QuickCategoryTile({
    super.key,
    required this.title,
    required this.icon,
    required this.color,
    required this.onTap,
    this.accentColor,
    this.imagePath,
  });

  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;
  final Color? accentColor;
  final String? imagePath;

  @override
  Widget build(BuildContext context) {
    final tint = accentColor ?? Colors.black87;

    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(28),
      child: InkWell(
        borderRadius: BorderRadius.circular(28),
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(28),
            image: imagePath == null
                ? null
                : DecorationImage(
                    image: AssetImage(imagePath!),
                    fit: BoxFit.cover,
                  ),
          ),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28),
              gradient: LinearGradient(
                colors: [
                  Colors.black.withValues(alpha: 0.10),
                  Colors.black.withValues(alpha: 0.38),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.92),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Icon(icon, size: 24, color: tint),
                    ),
                    const Spacer(),
                    Icon(Icons.arrow_outward_rounded, size: 22, color: Colors.white70),
                  ],
                ),
                const Spacer(),
                Text(
                  title,
                  style: AppTextStyles.sectionTitle.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
