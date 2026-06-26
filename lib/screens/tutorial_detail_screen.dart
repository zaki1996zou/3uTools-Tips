import 'package:flutter/material.dart';

import '../models/tutorial.dart';
import '../state/app_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_styles.dart';
import '../theme/app_theme_colors.dart';
import '../widgets/blue_chrome.dart';

class TutorialDetailScreen extends StatefulWidget {
  const TutorialDetailScreen({
    super.key,
    required this.tutorial,
    required this.appState,
  });

  final Tutorial tutorial;
  final AppState appState;

  @override
  State<TutorialDetailScreen> createState() => _TutorialDetailScreenState();
}

class _TutorialDetailScreenState extends State<TutorialDetailScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.appState.markCompleted(widget.tutorial.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final tutorial = widget.tutorial;
    final appState = widget.appState;

    return ListenableBuilder(
      listenable: appState,
      builder: (context, _) {
        final isBookmarked = appState.isBookmarked(tutorial.id);
        final tc = context.tc;

        return Scaffold(
          appBar: BlueDetailAppBar(
            title: 'Tutorial',
            actions: [
              IconButton(
                icon: Icon(
                  isBookmarked ? Icons.bookmark_rounded : Icons.bookmark_border_rounded,
                  color: Colors.white,
                ),
                onPressed: () => appState.toggleBookmark(tutorial.id),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(20, 8, 20, 0),
                  padding: const EdgeInsets.all(18),
                  decoration: AppStyles.bluePanel(context),
                  child: Row(
                    children: [
                      Container(
                        width: 52,
                        height: 52,
                        decoration: BoxDecoration(
                          color: AppColors.secondary,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Icon(tutorial.icon, color: Colors.white, size: 28),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(tutorial.title, style: AppStyles.pageTitle(context).copyWith(fontSize: 20)),
                            const SizedBox(height: 4),
                            Text(tutorial.subtitle, style: AppStyles.body(context)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 14, 20, 0),
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _MetaTag(label: tutorial.category, bg: tc.secondaryTint, fg: AppColors.secondary),
                      _MetaTag(
                        label: tutorial.difficultyLabel,
                        bg: _difficultyBg(tutorial.difficulty),
                        fg: _difficultyFg(tutorial.difficulty),
                      ),
                      _MetaTag(
                        label: '${tutorial.durationMinutes} min',
                        bg: tc.secondarySoft,
                        fg: tc.textMuted,
                        icon: Icons.access_time,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Steps', style: AppStyles.sectionLabel),
                      const SizedBox(height: 14),
                      ...List.generate(tutorial.steps.length, (index) {
                        final step = tutorial.steps[index];
                        final isLast = index == tutorial.steps.length - 1;
                        return _TimelineStep(
                          number: index + 1,
                          step: step,
                          isLast: isLast,
                        );
                      }),
                      if (tutorial.proTips.isNotEmpty) ...[
                        const SizedBox(height: 16),
                        Text('Pro tips', style: AppStyles.sectionLabel),
                        const SizedBox(height: 10),
                        ...tutorial.proTips.map((tip) => _ProTipCard(text: tip)),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Color _difficultyBg(TutorialDifficulty d) {
    switch (d) {
      case TutorialDifficulty.beginner:
        return AppColors.beginnerBg;
      case TutorialDifficulty.intermediate:
        return AppColors.intermediateBg;
      case TutorialDifficulty.advanced:
        return AppColors.advancedBg;
      case TutorialDifficulty.fixes:
        return AppColors.tagBg;
    }
  }

  Color _difficultyFg(TutorialDifficulty d) {
    switch (d) {
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

class _MetaTag extends StatelessWidget {
  const _MetaTag({
    required this.label,
    required this.bg,
    required this.fg,
    this.icon,
  });

  final String label;
  final Color bg;
  final Color fg;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 14, color: fg),
            const SizedBox(width: 4),
          ],
          Text(
            label,
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: fg),
          ),
        ],
      ),
    );
  }
}

class _TimelineStep extends StatelessWidget {
  const _TimelineStep({required this.number, required this.step, required this.isLast});

  final int number;
  final TutorialStep step;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final tc = context.tc;
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: 36,
            child: Column(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: const BoxDecoration(
                    color: AppColors.secondary,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '$number',
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 14),
                  ),
                ),
                if (!isLast)
                  Expanded(
                    child: Container(width: 2, margin: const EdgeInsets.symmetric(vertical: 4), color: AppColors.secondaryLight),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 16),
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: AppStyles.card(context, radius: AppStyles.radiusMd),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(step.title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: tc.textPrimary)),
                    const SizedBox(height: 6),
                    Text(step.description, style: AppStyles.body(context)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProTipCard extends StatelessWidget {
  const _ProTipCard({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final tc = context.tc;
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: tc.proTipBg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: tc.proTipBorder),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: AppColors.secondary,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.bolt_rounded, color: Colors.white, size: 16),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Pro Tip',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.secondary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  text,
                  style: TextStyle(
                    fontSize: 14,
                    color: tc.textPrimary,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
