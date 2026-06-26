import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'constants/app_config.dart';
import 'screens/splash_screen.dart';
import 'services/storage_service.dart';
import 'state/app_state.dart';
import 'theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  final storage = await StorageService.create();
  final appState = AppState(storage);
  await appState.load();

  runApp(ThreeUToolsApp(appState: appState));
}

class ThreeUToolsApp extends StatefulWidget {
  const ThreeUToolsApp({super.key, required this.appState});

  final AppState appState;

  @override
  State<ThreeUToolsApp> createState() => _ThreeUToolsAppState();
}

class _ThreeUToolsAppState extends State<ThreeUToolsApp> {
  @override
  void initState() {
    super.initState();
    widget.appState.addListener(_rebuild);
  }

  void _rebuild() => setState(() {});

  @override
  void dispose() {
    widget.appState.removeListener(_rebuild);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConfig.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: widget.appState.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: SplashScreen(appState: widget.appState),
    );
  }
}
