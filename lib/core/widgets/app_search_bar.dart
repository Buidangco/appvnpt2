import 'package:flutter/material.dart';

import '../../app/theme/app_colors.dart';
import '../../app/theme/app_text_styles.dart';

class AppSearchBar extends StatelessWidget {
  const AppSearchBar({
    super.key,
    this.controller,
    this.onChanged,
    this.hintText = 'Tìm kiếm',
    this.readOnly = false,
    this.onTap,
  });

  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final String hintText;
  final bool readOnly;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      readOnly: readOnly,
      onTap: onTap,
      style: AppTextStyles.body,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: Container(
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.primarySoft,
            borderRadius: BorderRadius.circular(14),
          ),
          child: const Icon(Icons.search_rounded, color: AppColors.primary),
        ),
        suffixIcon: readOnly
            ? const Padding(
                padding: EdgeInsets.only(right: 16),
                child: Icon(Icons.north_east_rounded, color: AppColors.textSecondary),
              )
            : null,
      ),
    );
  }
}
