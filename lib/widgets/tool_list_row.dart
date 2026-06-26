import 'package:flutter/material.dart';

import '../models/tool_item.dart';
import '../theme/app_colors.dart';
import '../theme/app_styles.dart';
import '../theme/app_theme_colors.dart';

class ToolListRow extends StatelessWidget {
  const ToolListRow({
    super.key,
    required this.tool,
    required this.onTap,
    this.index = 0,
  });

  final ToolItem tool;
  final VoidCallback onTap;
  final int index;

  @override
  Widget build(BuildContext context) {
    final tc = context.tc;
    final alt = index.isOdd;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Material(
        color: alt ? tc.secondaryMuted : tc.card,
        borderRadius: BorderRadius.circular(AppStyles.radiusMd),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppStyles.radiusMd),
          child: Ink(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppStyles.radiusMd),
              border: Border.all(color: tc.border),
            ),
            child: Row(
              children: [
                Container(
                  width: 5,
                  height: 72,
                  decoration: BoxDecoration(
                    gradient: AppStyles.accentGradient,
                    borderRadius: const BorderRadius.horizontal(left: Radius.circular(AppStyles.radiusMd)),
                  ),
                ),
                const SizedBox(width: 14),
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: tc.secondaryTint,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(tool.icon, color: AppColors.secondary, size: 24),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          tool.title,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            color: tc.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          tool.description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: AppStyles.caption(context),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 14),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: AppColors.secondary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      'Open',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 13),
                    ),
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
