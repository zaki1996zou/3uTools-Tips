import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants/app_config.dart';
import '../data/mock_data.dart';
import '../state/app_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_styles.dart';
import '../theme/app_theme_colors.dart';
import '../widgets/app_logo.dart';
import '../widgets/blue_chrome.dart';
import 'legal_screens.dart';
import 'tutorial_detail_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key, required this.appState});

  final AppState appState;

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String _version = '...';

  @override
  void initState() {
    super.initState();
    _loadVersion();
  }

  Future<void> _loadVersion() async {
    final info = await PackageInfo.fromPlatform();
    if (mounted) setState(() => _version = '${info.version} (${info.buildNumber})');
  }

  Future<void> _openUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.appState,
      builder: (context, _) {
        final s = widget.appState;
        final tc = context.tc;
        return Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: BlueHero(
                  title: 'Preferences',
                  subtitle: 'App settings & info',
                  leading: const AppLogoSmall(size: 36),
                ),
              ),
              SliverToBoxAdapter(
                child: Transform.translate(
                  offset: const Offset(0, -12),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      padding: const EdgeInsets.all(18),
                      decoration: AppStyles.card(context, radius: AppStyles.radiusLg),
                      child: Row(
                        children: [
                          _miniStat(context, '${s.completedCount}', 'Done', Icons.task_alt_rounded),
                          Container(width: 1, height: 40, color: tc.border),
                          _miniStat(context, '${s.bookmarkCount}', 'Saved', Icons.bookmark_rounded),
                          Container(width: 1, height: 40, color: tc.border),
                          _miniStat(context, _version.split(' ').first, 'Version', Icons.tag_rounded),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    _groupLabel('DISPLAY'),
                    _tile(
                      context,
                      icon: Icons.dark_mode_rounded,
                      title: 'Dark mode',
                      trailing: Switch.adaptive(
                        value: s.isDarkMode,
                        activeTrackColor: AppColors.secondary,
                        onChanged: s.setDarkMode,
                      ),
                    ),
                    const SizedBox(height: 20),
                    _groupLabel('YOUR CONTENT'),
                    _tile(
                      context,
                      icon: Icons.bookmark_rounded,
                      title: 'Saved guides',
                      subtitle: '${s.bookmarkCount} bookmarked',
                      onTap: () => _showBookmarks(context),
                    ),
                    _tile(
                      context,
                      icon: Icons.restart_alt_rounded,
                      title: 'Clear progress',
                      subtitle: '${s.completedCount} completed',
                      onTap: () => _confirmReset(context),
                    ),
                    const SizedBox(height: 20),
                    _groupLabel('LEGAL & SUPPORT'),
                    _tile(
                      context,
                      icon: Icons.privacy_tip_rounded,
                      title: 'Privacy policy',
                      onTap: () => _openUrl(AppConfig.privacyPolicyUrl),
                    ),
                    _tile(
                      context,
                      icon: Icons.support_agent_rounded,
                      title: 'Support',
                      subtitle: AppConfig.supportEmail,
                      onTap: () => _openUrl(AppConfig.supportUrl),
                    ),
                    _tile(
                      context,
                      icon: Icons.email_rounded,
                      title: 'Contact support',
                      subtitle: AppConfig.supportEmail,
                      onTap: () => _openUrl('mailto:${AppConfig.supportEmail}'),
                    ),
                    _tile(
                      context,
                      icon: Icons.info_rounded,
                      title: 'About & disclaimer',
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AboutScreen())),
                    ),
                    _tile(
                      context,
                      icon: Icons.language_rounded,
                      title: 'Apple iPhone Support',
                      onTap: () => _openUrl(AppConfig.appleSupportUrl),
                    ),
                  ]),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _miniStat(BuildContext context, String value, String label, IconData icon) {
    final tc = context.tc;
    return Expanded(
      child: Column(
        children: [
          Icon(icon, color: AppColors.secondary, size: 20),
          const SizedBox(height: 6),
          Text(value, style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16, color: tc.textPrimary)),
          Text(label, style: AppStyles.caption(context)),
        ],
      ),
    );
  }

  Widget _groupLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, left: 4),
      child: Text(text, style: AppStyles.sectionLabel),
    );
  }

  Widget _tile(
    BuildContext context, {
    required IconData icon,
    required String title,
    String? subtitle,
    VoidCallback? onTap,
    Widget? trailing,
  }) {
    final tc = context.tc;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: tc.secondarySoft,
        borderRadius: BorderRadius.circular(AppStyles.radiusMd),
        child: ListTile(
          onTap: onTap,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppStyles.radiusMd)),
          leading: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: tc.secondaryTint,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: AppColors.secondary),
          ),
          title: Text(title, style: TextStyle(fontWeight: FontWeight.w600, color: tc.textPrimary)),
          subtitle: subtitle != null ? Text(subtitle, style: AppStyles.caption(context)) : null,
          trailing: trailing ?? (onTap != null ? const Icon(Icons.chevron_right_rounded, color: AppColors.secondary) : null),
        ),
      ),
    );
  }

  void _showBookmarks(BuildContext context) {
    final tc = context.tc;
    final bookmarks = MockData.tutorials.where((t) => widget.appState.isBookmarked(t.id)).toList();
    showModalBottomSheet(
      context: context,
      builder: (ctx) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Saved guides', style: AppStyles.pageTitle(context)),
              const SizedBox(height: 12),
              if (bookmarks.isEmpty)
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Center(child: Text('Nothing saved yet', style: TextStyle(color: tc.textSecondary))),
                )
              else
                ...bookmarks.map((t) => ListTile(
                      leading: Icon(t.icon, color: AppColors.secondary),
                      title: Text(t.title, style: TextStyle(color: tc.textPrimary)),
                      onTap: () {
                        Navigator.pop(ctx);
                        Navigator.push(context, MaterialPageRoute(
                          builder: (_) => TutorialDetailScreen(tutorial: t, appState: widget.appState),
                        ));
                      },
                    )),
            ],
          ),
        ),
      ),
    );
  }

  void _confirmReset(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Clear progress?'),
        content: const Text('This removes all completed guide markers.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: AppColors.secondary),
            onPressed: () {
              widget.appState.resetProgress();
              Navigator.pop(ctx);
            },
            child: const Text('Clear'),
          ),
        ],
      ),
    );
  }
}
