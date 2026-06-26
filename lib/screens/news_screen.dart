import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../data/mock_data.dart';
import '../models/news_article.dart';
import '../theme/app_colors.dart';
import '../theme/app_styles.dart';
import '../widgets/blue_chrome.dart';
import '../widgets/resource_link_row.dart';
import '../widgets/segmented_filter.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  String _selectedCategory = 'All';

  List<NewsArticle> get _filtered {
    if (_selectedCategory == 'All') return MockData.newsArticles;
    return MockData.newsArticles.where((a) => a.category == _selectedCategory).toList();
  }

  Future<void> _openArticle(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      final opened = await launchUrl(uri, mode: LaunchMode.externalApplication);
      if (!opened && mounted) _showError();
    } else if (mounted) {
      _showError();
    }
  }

  void _showError() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Could not open link'),
        backgroundColor: AppColors.secondary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final articles = _filtered;

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const BlueHero(
            title: 'Useful Links',
            subtitle: 'Official resources & references',
          ),
          CategoryStrip(
            items: MockData.newsCategories,
            selected: _selectedCategory,
            onSelected: (v) => setState(() => _selectedCategory = v),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.fromLTRB(20, 16, 20, 0),
              decoration: AppStyles.card(context, radius: AppStyles.radiusLg),
              clipBehavior: Clip.antiAlias,
              child: articles.isEmpty
                  ? const Center(child: Text('No links in this category'))
                  : ListView.builder(
                      itemCount: articles.length,
                      itemBuilder: (context, i) => ResourceLinkRow(
                        article: articles[i],
                        onTap: () => _openArticle(articles[i].url),
                      ),
                    ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
