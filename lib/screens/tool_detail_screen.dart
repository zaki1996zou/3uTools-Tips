import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants/app_config.dart';
import '../data/mock_data.dart';
import '../data/tool_reference_data.dart';
import '../models/tool_item.dart';
import '../theme/app_colors.dart';
import '../theme/app_styles.dart';
import '../theme/app_theme_colors.dart';
import '../widgets/blue_chrome.dart';

class ToolDetailScreen extends StatefulWidget {
  const ToolDetailScreen({super.key, required this.toolId});

  final String toolId;

  @override
  State<ToolDetailScreen> createState() => _ToolDetailScreenState();
}

class _ToolDetailScreenState extends State<ToolDetailScreen> {
  final _searchController = TextEditingController();
  final _checkedItems = <int>{};

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  ToolItem? get _tool {
    try {
      return MockData.tools.firstWhere((t) => t.id == widget.toolId);
    } catch (_) {
      return null;
    }
  }

  Future<void> _openUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      final opened = await launchUrl(uri, mode: LaunchMode.externalApplication);
      if (!opened && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not open link')),
        );
      }
    } else if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not open link')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final tool = _tool;
    if (tool == null) {
      return const Scaffold(body: Center(child: Text('Tool not found')));
    }

    return Scaffold(
      appBar: BlueDetailAppBar(title: tool.title),
      body: switch (widget.toolId) {
        'tool1' => _buildIosVersions(),
        'tool2' => _buildCompatibility(),
        'tool3' => _buildDfuGuide(),
        'tool4' => _buildErrorLookup(),
        'tool5' => _buildFirmwareFinder(),
        'tool6' => _buildBackupChecker(),
        _ => _buildDefault(tool),
      },
    );
  }

  Widget _buildIosVersions() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _infoCard(
          'Check on your iPhone',
          'Go to Settings → General → About → iOS Version to see your installed version.',
        ),
        const SizedBox(height: 12),
        ...ToolReferenceData.iosVersions.map((v) {
          return Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.all(16),
            decoration: _cardDecoration(),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(v.$1, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: context.tc.textPrimary)),
                      const SizedBox(height: 4),
                      Text(v.$2, style: TextStyle(color: context.tc.textSecondary)),
                      const SizedBox(height: 4),
                      Text(v.$3, style: TextStyle(color: context.tc.textMuted, fontSize: 12)),
                    ],
                  ),
                ),
                if (v.$4)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.beginnerBg,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Text('Recent', style: TextStyle(color: AppColors.beginner, fontSize: 11)),
                  ),
              ],
            ),
          );
        }),
        const SizedBox(height: 8),
        _linkButton('Apple Software Update Guide', AppConfig.appleIosVersionsUrl),
      ],
    );
  }

  Widget _buildCompatibility() {
    final query = _searchController.text.toLowerCase();
    final devices = ToolReferenceData.devices
        .where((d) => query.isEmpty || d.$1.toLowerCase().contains(query))
        .toList();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: TextField(
            controller: _searchController,
            onChanged: (_) => setState(() {}),
            decoration: InputDecoration(
              hintText: 'Search iPhone model...',
              prefixIcon: const Icon(Icons.search, color: AppColors.primary),
              filled: true,
              fillColor: context.tc.inputFill,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: devices.length,
            itemBuilder: (_, i) {
              final d = devices[i];
              return Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.all(16),
                decoration: _cardDecoration(),
                child: Row(
                  children: [
                    const Icon(Icons.phone_iphone, color: AppColors.primary),
                    const SizedBox(width: 12),
                    Expanded(child: Text(d.$1, style: TextStyle(fontWeight: FontWeight.w600, color: context.tc.textPrimary))),
                    Text(d.$2, style: TextStyle(color: context.tc.textMuted, fontSize: 13)),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildDfuGuide() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _infoCard(
          'DFU Mode',
          'Device Firmware Update mode allows 3uTools to restore or flash your iPhone when normal recovery fails.',
        ),
        const SizedBox(height: 12),
        ...List.generate(ToolReferenceData.dfuSteps.length, (i) {
          final step = ToolReferenceData.dfuSteps[i];
          return Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.all(16),
            decoration: _cardDecoration(),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundColor: AppColors.primary,
                  child: Text('${i + 1}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(step.$1, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15, color: context.tc.textPrimary)),
                      const SizedBox(height: 4),
                      Text(step.$2, style: TextStyle(color: context.tc.textSecondary, height: 1.4)),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
        _infoCard(
          'Note',
          'Button combinations differ for iPhone 8 and earlier (use Home + Power). '
          'Search your model on Apple Support for exact steps.',
        ),
      ],
    );
  }

  Widget _buildErrorLookup() {
    final query = _searchController.text.toLowerCase();
    final codes = ToolReferenceData.errorCodes.where((e) {
      return query.isEmpty ||
          e.$1.contains(query) ||
          e.$2.toLowerCase().contains(query);
    }).toList();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: TextField(
            controller: _searchController,
            onChanged: (_) => setState(() {}),
            decoration: InputDecoration(
              hintText: 'Search error code or message...',
              prefixIcon: const Icon(Icons.search, color: AppColors.primary),
              filled: true,
              fillColor: context.tc.inputFill,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: codes.length,
            itemBuilder: (_, i) {
              final e = codes[i];
              return Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.all(16),
                decoration: _cardDecoration(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.tagBg,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text('Error ${e.$1}', style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(e.$2, style: const TextStyle(fontWeight: FontWeight.w600)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(e.$3, style: const TextStyle(color: AppColors.textSecondary, height: 1.4)),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildFirmwareFinder() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _infoCard(
          'Find Signed Firmware',
          'Before flashing or restoring, verify that Apple is still signing the iOS version you need. '
          'Unsigned versions cannot be installed unless you have saved SHSH blobs.',
        ),
        const SizedBox(height: 16),
        _linkButton('Open IPSW.me Firmware Finder', AppConfig.ipswMeUrl),
        const SizedBox(height: 12),
        _linkButton('Official 3uTools Download', AppConfig.official3uToolsUrl),
        const SizedBox(height: 20),
        const Text('How to use IPSW.me:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 12),
        ...['Select your iPhone model', 'Choose a signed iOS version (green)', 'Download the IPSW file', 'Use 3uTools Flash to install'].map(
          (step) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.check_circle, color: AppColors.primary, size: 20),
                const SizedBox(width: 8),
                Expanded(child: Text(step)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBackupChecker() {
    final total = ToolReferenceData.backupChecklist.length;
    final done = _checkedItems.length;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: AppStyles.accentGradient,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              Text(
                '$done / $total',
                style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const Text('checks completed', style: TextStyle(color: Colors.white70)),
            ],
          ),
        ),
        const SizedBox(height: 16),
        ...List.generate(total, (i) {
          final item = ToolReferenceData.backupChecklist[i];
          final checked = _checkedItems.contains(i);
          return Container(
            margin: const EdgeInsets.only(bottom: 8),
            decoration: _cardDecoration(),
            child: CheckboxListTile(
              value: checked,
              activeColor: AppColors.primary,
              onChanged: (v) {
                setState(() {
                  if (v == true) {
                    _checkedItems.add(i);
                  } else {
                    _checkedItems.remove(i);
                  }
                });
              },
              title: Text(item, style: const TextStyle(fontSize: 14)),
            ),
          );
        }),
        if (done == total)
          Container(
            margin: const EdgeInsets.only(top: 8),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.beginnerBg,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Row(
              children: [
                Icon(Icons.check_circle, color: AppColors.beginner),
                SizedBox(width: 8),
                Expanded(child: Text('Your backup setup looks good!', style: TextStyle(fontWeight: FontWeight.w600))),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildDefault(ToolItem tool) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Text(tool.description, textAlign: TextAlign.center),
      ),
    );
  }

  BoxDecoration _cardDecoration() => AppStyles.card(context, radius: AppStyles.radiusMd);

  Widget _infoCard(String title, String body) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: context.tc.textPrimary)),
          const SizedBox(height: 8),
          Text(body, style: TextStyle(color: context.tc.textSecondary, height: 1.4)),
        ],
      ),
    );
  }

  Widget _linkButton(String label, String url) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () => _openUrl(url),
        icon: const Icon(Icons.open_in_new),
        label: Text(label),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppStyles.radiusMd)),
        ),
      ),
    );
  }
}
