import 'package:flutter/material.dart';

import '../data/mock_data.dart';
import '../models/tutorial.dart';
import '../state/app_state.dart';
import '../theme/app_styles.dart';
import '../widgets/blue_chrome.dart';
import '../widgets/segmented_filter.dart';
import '../widgets/tutorial_timeline_tile.dart';
import 'tutorial_detail_screen.dart';

class TutorialsScreen extends StatefulWidget {
  const TutorialsScreen({super.key, required this.appState});

  final AppState appState;

  @override
  State<TutorialsScreen> createState() => _TutorialsScreenState();
}

class _TutorialsScreenState extends State<TutorialsScreen> {
  String _difficultyFilter = 'All';
  String _categoryFilter = 'All';
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Tutorial> get _filtered {
    var list = MockData.tutorials;
    if (_difficultyFilter != 'All') {
      list = list.where((t) {
        if (_difficultyFilter == 'Fixes') return t.difficulty == TutorialDifficulty.fixes;
        return t.difficultyLabel == _difficultyFilter;
      }).toList();
    }
    if (_categoryFilter != 'All') {
      list = list.where((t) {
        return t.category.toLowerCase() == _categoryFilter.toLowerCase() ||
            t.title.toLowerCase().contains(_categoryFilter.toLowerCase());
      }).toList();
    }
    final q = _searchController.text.trim().toLowerCase();
    if (q.isNotEmpty) {
      list = list.where((t) => t.title.toLowerCase().contains(q) || t.category.toLowerCase().contains(q)).toList();
    }
    return list;
  }

  void _openTutorial(Tutorial tutorial) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => TutorialDetailScreen(tutorial: tutorial, appState: widget.appState),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tutorials = _filtered;

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          BlueHero(
            title: 'Guide Library',
            subtitle: '${MockData.tutorials.length} tutorials available',
            bottom: HeroSearchField(
              hint: 'Filter guides…',
              controller: _searchController,
              onChanged: (_) => setState(() {}),
            ),
          ),
          const SizedBox(height: 12),
          SegmentedFilter(
            items: MockData.tutorialDifficultyFilters,
            selected: _difficultyFilter,
            onSelected: (v) => setState(() => _difficultyFilter = v),
          ),
          const SizedBox(height: 12),
          CategoryStrip(
            items: MockData.tutorialCategoryFilters,
            selected: _categoryFilter,
            onSelected: (v) => setState(() => _categoryFilter = v),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
            child: Text(
              '${tutorials.length} result${tutorials.length == 1 ? '' : 's'}',
              style: AppStyles.caption(context).copyWith(fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
              itemCount: tutorials.length,
              itemBuilder: (context, i) => TutorialTimelineTile(
                tutorial: tutorials[i],
                index: i,
                isLast: i == tutorials.length - 1,
                onTap: () => _openTutorial(tutorials[i]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
