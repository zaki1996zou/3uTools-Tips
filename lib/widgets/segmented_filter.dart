import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_styles.dart';
import '../theme/app_theme_colors.dart';

/// iOS-style segmented control with blue active state.
class SegmentedFilter extends StatelessWidget {
  const SegmentedFilter({
    super.key,
    required this.items,
    required this.selected,
    required this.onSelected,
    this.margin = const EdgeInsets.symmetric(horizontal: 20),
  });

  final List<String> items;
  final String selected;
  final ValueChanged<String> onSelected;
  final EdgeInsets margin;

  @override
  Widget build(BuildContext context) {
    final tc = context.tc;
    return Container(
      margin: margin,
      padding: const EdgeInsets.all(4),
      decoration: AppStyles.bluePanel(context, radius: AppStyles.radiusMd),
      child: Row(
        children: items.map((item) {
          final isSelected = item == selected;
          return Expanded(
            child: GestureDetector(
              onTap: () => onSelected(item),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.secondary : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: AppColors.secondary.withValues(alpha: 0.35),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ]
                      : null,
                ),
                alignment: Alignment.center,
                child: Text(
                  item,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: isSelected ? Colors.white : tc.textSecondary,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

/// Horizontal category pills on secondary background strip.
class CategoryStrip extends StatelessWidget {
  const CategoryStrip({
    super.key,
    required this.items,
    required this.selected,
    required this.onSelected,
  });

  final List<String> items;
  final String selected;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    final tc = context.tc;
    return Container(
      color: tc.secondarySoft,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: SizedBox(
        height: 36,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          itemCount: items.length,
          separatorBuilder: (_, __) => const SizedBox(width: 8),
          itemBuilder: (_, i) {
            final item = items[i];
            final active = item == selected;
            return GestureDetector(
              onTap: () => onSelected(item),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: active ? AppColors.secondary : tc.pillSurface,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: active ? AppColors.secondary : tc.border,
                  ),
                ),
                child: Text(
                  item,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: active ? Colors.white : tc.textSecondary,
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
