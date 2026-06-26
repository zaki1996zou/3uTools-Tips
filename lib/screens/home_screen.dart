import 'package:flutter/material.dart';

import '../data/mock_data.dart';
import '../models/tutorial.dart';
import '../state/app_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_styles.dart';
import '../theme/app_theme_colors.dart';
import '../widgets/app_logo.dart';
import '../widgets/blue_chrome.dart';
import '../widgets/theme_toggle_button.dart';
import '../widgets/tutorial_timeline_tile.dart';
import 'tool_detail_screen.dart';
import 'tutorial_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    required this.appState,
    required this.onNavigate,
  });

  final AppState appState;
  final ValueChanged<int> onNavigate;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _searchController = TextEditingController();
  final _searchFocusNode = FocusNode();

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  List<Tutorial> get _results {
    final q = _searchController.text.trim().toLowerCase();
    if (q.isEmpty) return MockData.tutorials;
    return MockData.tutorials
        .where((t) => t.title.toLowerCase().contains(q) || t.category.toLowerCase().contains(q))
        .toList();
  }

  void _openTutorial(String id) {
    final t = MockData.tutorialById(id);
    if (t == null) return;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => TutorialDetailScreen(tutorial: t, appState: widget.appState),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final featured = MockData.featuredGuides.first;
    final featuredTutorial = MockData.tutorialById(featured.tutorialId);
    final results = _results.take(4).toList();

    return ListenableBuilder(
      listenable: widget.appState,
      builder: (context, _) {
        final completed = widget.appState.completedCount;
        final bookmarks = widget.appState.bookmarkCount;

        return Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: BlueHero(
                  title: '3uTools Tips',
                  subtitle: 'Your iPhone guide hub',
                  leading: const AppLogoSmall(size: 40),
                  trailing: ThemeToggleButton(
                    isDarkMode: widget.appState.isDarkMode,
                    onPressed: () => widget.appState.setDarkMode(!widget.appState.isDarkMode),
                  ),
                  bottom: HeroSearchField(
                    hint: 'Find a guide or tool…',
                    controller: _searchController,
                    focusNode: _searchFocusNode,
                    onChanged: (_) => setState(() {}),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Transform.translate(
                  offset: const Offset(0, -8),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        StatBlock(
                          value: '$completed',
                          label: 'Completed',
                          icon: Icons.check_circle_outline_rounded,
                          onTap: () => widget.onNavigate(1),
                        ),
                        const SizedBox(width: 10),
                        StatBlock(
                          value: '$bookmarks',
                          label: 'Saved',
                          icon: Icons.bookmark_outline_rounded,
                          onTap: () => widget.onNavigate(4),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
                  child: GestureDetector(
                    onTap: () => _openTutorial(featured.tutorialId),
                    child: Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        gradient: AppStyles.heroGradient,
                        borderRadius: BorderRadius.circular(AppStyles.radiusLg),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'RECOMMENDED',
                                  style: TextStyle(
                                    color: AppColors.textOnBlueMuted,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: 1,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  featured.title,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white,
                                    height: 1.2,
                                  ),
                                ),
                                if (featuredTutorial != null) ...[
                                  const SizedBox(height: 4),
                                  Text(
                                    '${featuredTutorial.durationMinutes} min read',
                                    style: const TextStyle(color: AppColors.textOnBlueMuted, fontSize: 13),
                                  ),
                                ],
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: const Icon(Icons.play_arrow_rounded, color: AppColors.secondary, size: 28),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 10),
                  child: Text('QUICK ACTIONS', style: AppStyles.sectionLabel),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, i) {
                      final actions = [
                        ('Flash iOS firmware', Icons.bolt_rounded, () => _openTutorial('t2')),
                        ('Backup your iPhone', Icons.cloud_upload_rounded, () => _openTutorial('t3')),
                        ('Error code lookup', Icons.error_outline_rounded, () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => const ToolDetailScreen(toolId: 'tool4')),
                          );
                        }),
                        ('Browse all tools', Icons.apps_rounded, () => widget.onNavigate(2)),
                      ];
                      final a = actions[i];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Material(
                          color: context.tc.secondarySoft,
                          borderRadius: BorderRadius.circular(AppStyles.radiusMd),
                          child: InkWell(
                            onTap: a.$3,
                            borderRadius: BorderRadius.circular(AppStyles.radiusMd),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                              child: Row(
                                children: [
                                  Icon(a.$2, color: AppColors.secondary, size: 22),
                                  const SizedBox(width: 14),
                                  Expanded(
                                    child: Text(
                                      a.$1,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15,
                                        color: context.tc.textPrimary,
                                      ),
                                    ),
                                  ),
                                  const Icon(Icons.arrow_forward_rounded, color: AppColors.secondary, size: 20),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    childCount: 4,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
                  child: Row(
                    children: [
                      const Expanded(child: Text('GUIDE TIMELINE', style: AppStyles.sectionLabel)),
                      TextButton(
                        onPressed: () => widget.onNavigate(1),
                        child: const Text('View all'),
                      ),
                    ],
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, i) => TutorialTimelineTile(
                      tutorial: results[i],
                      index: i,
                      isLast: i == results.length - 1,
                      showRating: false,
                      onTap: () => _openTutorial(results[i].id),
                    ),
                    childCount: results.length,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
