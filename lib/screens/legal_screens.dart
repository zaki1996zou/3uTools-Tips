import 'package:flutter/material.dart';

import '../constants/app_config.dart';
import '../theme/app_theme_colors.dart';
import '../widgets/blue_chrome.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tc = context.tc;
    return Scaffold(
      appBar: const BlueDetailAppBar(title: 'Privacy Policy'),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            'Privacy Policy',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: tc.textPrimary),
          ),
          const SizedBox(height: 8),
          Text('Last updated: July 2026', style: TextStyle(color: tc.textMuted)),
          const SizedBox(height: 20),
          const _Section(
            title: 'Overview',
            body:
                '${AppConfig.appName} is an independent educational app that provides tutorials, '
                'guides, and reference tools for iPhone users. We respect your privacy and collect minimal data.',
          ),
          const _Section(
            title: 'Data We Collect',
            body:
                'This app stores the following data locally on your device only:\n\n'
                '• Dark mode preference\n'
                '• Bookmarked tutorials\n'
                '• Tutorial completion progress\n'
                '• Disclaimer acceptance status\n\n'
                'No personal information is transmitted to our servers. We do not use analytics, '
                'advertising SDKs, or tracking.',
          ),
          const _Section(
            title: 'Third-Party Links',
            body:
                'The app may open external websites (such as Apple Support or IPSW.me) '
                'when you tap resource links. Those sites have their own privacy policies.',
          ),
          const _Section(
            title: 'Children',
            body: 'This app is not directed at children under 13 and does not knowingly collect data from children.',
          ),
          const _Section(
            title: 'Contact',
            body:
                'For privacy questions, contact us at ${AppConfig.supportEmail} or visit '
                '${AppConfig.privacyPolicyUrl}.',
          ),
        ],
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.title, required this.body});

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    final tc = context.tc;
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: tc.textPrimary)),
          const SizedBox(height: 8),
          Text(body, style: TextStyle(color: tc.textSecondary, height: 1.5)),
        ],
      ),
    );
  }
}

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tc = context.tc;
    return Scaffold(
      appBar: const BlueDetailAppBar(title: 'About'),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Center(
            child: Text(
              AppConfig.appName,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: tc.textPrimary),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: tc.proTipBg,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: tc.proTipBorder),
            ),
            child: Text(
              AppConfig.disclaimer,
              style: TextStyle(height: 1.5, color: tc.textPrimary),
            ),
          ),
          const SizedBox(height: 20),
          const _Section(
            title: 'What This App Does',
            body:
                '• Step-by-step tutorials for iPhone management from a Mac or PC\n'
                '• Quick reference tools (error codes, DFU guide, firmware finder)\n'
                '• Curated links to Apple and community resources\n'
                '• Bookmark and track your learning progress',
          ),
          const _Section(
            title: 'Desktop Software Required',
            body:
                'To flash, back up, or restore an iPhone, you need desktop software on a Mac or PC '
                'and a USB connection. This app provides guides and references only.',
          ),
        ],
      ),
    );
  }
}
