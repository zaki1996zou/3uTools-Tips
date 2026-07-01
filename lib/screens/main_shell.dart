import 'package:flutter/material.dart';

import '../constants/app_config.dart';
import '../state/app_state.dart';
import '../theme/app_colors.dart';
import '../widgets/dock_nav_bar.dart';
import 'home_screen.dart';
import 'news_screen.dart';
import 'settings_screen.dart';
import 'tools_screen.dart';
import 'tutorials_screen.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key, required this.appState});

  final AppState appState;

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  @override
  void initState() {
    super.initState();
    widget.appState.addListener(_onStateChanged);
    WidgetsBinding.instance.addPostFrameCallback((_) => _showDisclaimerIfNeeded());
  }

  void _showDisclaimerIfNeeded() {
    if (!widget.appState.disclaimerAccepted && mounted) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (ctx) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Text('Welcome', style: TextStyle(fontWeight: FontWeight.w800)),
          content: const Text(
            '${AppConfig.appName} is an unofficial companion for guides and reference tools. '
            'For device management, use desktop iPhone utility software on a Mac or PC with a USB cable.',
            style: TextStyle(height: 1.45),
          ),
          actions: [
            FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.secondary,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                widget.appState.acceptDisclaimer();
                Navigator.pop(ctx);
              },
              child: const Text('Got it'),
            ),
          ],
        ),
      );
    }
  }

  void _onStateChanged() => setState(() {});

  @override
  void dispose() {
    widget.appState.removeListener(_onStateChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appState = widget.appState;
    final screens = [
      HomeScreen(appState: appState, onNavigate: appState.setSelectedTab),
      TutorialsScreen(appState: appState),
      const ToolsScreen(),
      const NewsScreen(),
      SettingsScreen(appState: appState),
    ];

    return AppStateScope(
      appState: appState,
      child: Scaffold(
        body: IndexedStack(index: appState.selectedTab, children: screens),
        bottomNavigationBar: DockNavBar(
          currentIndex: appState.selectedTab,
          onTap: appState.setSelectedTab,
        ),
      ),
    );
  }
}

class AppStateScope extends InheritedWidget {
  const AppStateScope({super.key, required this.appState, required super.child});

  final AppState appState;

  static AppState of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<AppStateScope>();
    assert(scope != null, 'AppStateScope not found');
    return scope!.appState;
  }

  @override
  bool updateShouldNotify(AppStateScope oldWidget) => appState != oldWidget.appState;
}
