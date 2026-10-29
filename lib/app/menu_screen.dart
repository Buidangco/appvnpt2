import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'theme/app_colors.dart';
import 'theme/app_text_styles.dart';

class _MenuEntry {
  const _MenuEntry({required this.icon, required this.label, required this.path});

  final IconData icon;
  final String label;
  final String path;
}

const _entries = [
  _MenuEntry(icon: Icons.home_rounded, label: 'Trang chủ', path: '/home'),
  _MenuEntry(icon: Icons.play_circle_rounded, label: 'Video', path: '/videos'),
  _MenuEntry(icon: Icons.explore_rounded, label: 'Khám phá', path: '/explore'),
  _MenuEntry(icon: Icons.newspaper_rounded, label: 'Tin tức', path: '/news'),
  _MenuEntry(icon: Icons.support_agent_rounded, label: 'Liên hệ', path: '/contacts'),
];

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Menu')),
      body: SafeArea(
        child: ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: _entries.length,
          separatorBuilder: (_, index) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final entry = _entries[index];
            return Material(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(20),
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () => context.go(entry.path),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 16,
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: AppColors.primarySoft,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Icon(entry.icon, color: AppColors.primary),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(entry.label, style: AppTextStyles.cardTitle),
                      ),
                      const Icon(
                        Icons.chevron_right_rounded,
                        color: AppColors.textSecondary,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
