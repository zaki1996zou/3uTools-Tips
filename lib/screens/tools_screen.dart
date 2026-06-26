import 'package:flutter/material.dart';

import '../data/mock_data.dart';
import '../theme/app_colors.dart';
import '../theme/app_styles.dart';
import '../theme/app_theme_colors.dart';
import '../widgets/blue_chrome.dart';
import '../widgets/tool_list_row.dart';
import 'tool_detail_screen.dart';

class ToolsScreen extends StatelessWidget {
  const ToolsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const BlueHero(
            title: 'Toolkit',
            subtitle: 'Reference utilities for your iPhone',
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: AppStyles.bluePanel(context),
              child: Row(
                children: [
                  const Icon(Icons.info_outline_rounded, color: AppColors.secondary, size: 20),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'These tools provide on-device reference guides. Connect your iPhone to a PC for full 3uTools features.',
                      style: TextStyle(fontSize: 13, color: context.tc.textSecondary, height: 1.35),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
              itemCount: MockData.tools.length,
              itemBuilder: (context, i) {
                final tool = MockData.tools[i];
                return ToolListRow(
                  tool: tool,
                  index: i,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => ToolDetailScreen(toolId: tool.id)),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
