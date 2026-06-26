import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_theme_colors.dart';

class DockNavBar extends StatelessWidget {
  const DockNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;

  static const _items = [
    (Icons.dashboard_rounded, 'Hub'),
    (Icons.library_books_rounded, 'Guides'),
    (Icons.handyman_rounded, 'Toolkit'),
    (Icons.link_rounded, 'Links'),
    (Icons.tune_rounded, 'Prefs'),
  ];

  @override
  Widget build(BuildContext context) {
    final tc = context.tc;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.secondary,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: AppColors.secondary.withValues(alpha: 0.45),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
            child: Row(
              children: List.generate(_items.length, (i) {
                final active = i == currentIndex;
                final item = _items[i];
                return Expanded(
                  child: GestureDetector(
                    onTap: () => onTap(i),
                    behavior: HitTestBehavior.opaque,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 220),
                      curve: Curves.easeOutCubic,
                      margin: const EdgeInsets.symmetric(horizontal: 2),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        color: active ? tc.dockActiveBg : Colors.transparent,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            item.$1,
                            size: 22,
                            color: active ? AppColors.secondary : Colors.white.withValues(alpha: 0.85),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            item.$2,
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: active ? AppColors.secondary : Colors.white.withValues(alpha: 0.9),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
