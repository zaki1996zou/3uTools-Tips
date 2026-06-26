import 'package:flutter/material.dart';

import '../models/news_article.dart';
import '../theme/app_colors.dart';
import '../theme/app_styles.dart';
import '../theme/app_theme_colors.dart';

class ResourceLinkRow extends StatelessWidget {
  const ResourceLinkRow({
    super.key,
    required this.article,
    required this.onTap,
  });

  final NewsArticle article;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final tc = context.tc;
    return Material(
      color: tc.card,
      child: InkWell(
        onTap: onTap,
        child: Ink(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: tc.border)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: tc.secondaryTint,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.open_in_new_rounded, color: AppColors.secondary, size: 20),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      article.category.toUpperCase(),
                      style: AppStyles.sectionLabel.copyWith(fontSize: 11),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      article.title,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: tc.textPrimary,
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      article.summary,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppStyles.caption(context),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right_rounded, color: AppColors.secondary),
            ],
          ),
        ),
      ),
    );
  }
}
