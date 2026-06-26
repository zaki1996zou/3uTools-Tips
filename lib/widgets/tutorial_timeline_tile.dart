import 'package:flutter/material.dart';

import '../models/tutorial.dart';
import '../theme/app_colors.dart';
import '../theme/app_styles.dart';
import '../theme/app_theme_colors.dart';

/// Timeline-style tutorial row — distinct from card layout.
class TutorialTimelineTile extends StatelessWidget {
  const TutorialTimelineTile({
    super.key,
    required this.tutorial,
    required this.index,
    required this.isLast,
    required this.onTap,
    this.showRating = true,
  });

  final Tutorial tutorial;
  final int index;
  final bool isLast;
  final VoidCallback onTap;
  final bool showRating;

  @override
  Widget build(BuildContext context) {
    final tc = context.tc;
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: 48,
            child: Column(
              children: [
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    gradient: AppStyles.accentGradient,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.secondary.withValues(alpha: 0.35),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '${index + 1}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 13,
                    ),
                  ),
                ),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      color: AppColors.secondaryLight,
                    ),
                  ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 14),
              child: Material(
                color: tc.card,
                borderRadius: BorderRadius.circular(AppStyles.radiusMd),
                child: InkWell(
                  onTap: onTap,
                  borderRadius: BorderRadius.circular(AppStyles.radiusMd),
                  child: Ink(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppStyles.radiusMd),
                      border: Border.all(color: tc.border),
                    ),
                    padding: const EdgeInsets.all(14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                tutorial.title,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: tc.textPrimary,
                                  letterSpacing: -0.2,
                                  height: 1.25,
                                ),
                              ),
                            ),
                            const Icon(Icons.north_east_rounded, size: 18, color: AppColors.secondary),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 6,
                          runSpacing: 4,
                          children: [
                            _pill(tutorial.category, tc.secondaryTint, AppColors.primary),
                            _pill(tutorial.difficultyLabel, _diffBg(tutorial, tc), _diffFg(tutorial)),
                            _pill('${tutorial.durationMinutes} min', tc.secondarySoft, tc.textMuted),
                          ],
                        ),
                        if (showRating) ...[
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              ...List.generate(5, (i) => Icon(
                                    i < tutorial.rating.floor() ? Icons.star_rounded : Icons.star_outline_rounded,
                                    size: 14,
                                    color: AppColors.star,
                                  )),
                              const SizedBox(width: 4),
                              Text(tutorial.rating.toStringAsFixed(1), style: AppStyles.caption(context)),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _pill(String text, Color bg, Color fg) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(6)),
      child: Text(text, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: fg)),
    );
  }

  Color _diffBg(Tutorial t, AppThemeColors tc) {
    switch (t.difficulty) {
      case TutorialDifficulty.beginner:
        return AppColors.beginnerBg;
      case TutorialDifficulty.intermediate:
        return AppColors.intermediateBg;
      case TutorialDifficulty.advanced:
        return AppColors.advancedBg;
      case TutorialDifficulty.fixes:
        return tc.secondaryTint;
    }
  }

  Color _diffFg(Tutorial t) {
    switch (t.difficulty) {
      case TutorialDifficulty.beginner:
        return AppColors.beginner;
      case TutorialDifficulty.intermediate:
        return AppColors.intermediate;
      case TutorialDifficulty.advanced:
        return AppColors.advanced;
      case TutorialDifficulty.fixes:
        return AppColors.primary;
    }
  }
}
