import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_colors.dart';
import 'app_theme_colors.dart';

abstract final class AppTheme {
  static ThemeData light() {
    final tc = AppThemeColors.light;
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: tc.background,
      canvasColor: tc.background,
      dividerColor: tc.border,
      splashColor: AppColors.secondary.withValues(alpha: 0.1),
      highlightColor: AppColors.secondary.withValues(alpha: 0.06),
      colorScheme: ColorScheme.light(
        primary: AppColors.primary,
        secondary: AppColors.primary,
        surface: tc.card,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: tc.textPrimary,
      ),
      extensions: const [AppThemeColors.light],
      appBarTheme: AppBarTheme(
        backgroundColor: tc.card,
        foregroundColor: tc.textPrimary,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        surfaceTintColor: Colors.transparent,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
        titleTextStyle: TextStyle(
          color: tc.textPrimary,
          fontSize: 17,
          fontWeight: FontWeight.w600,
          letterSpacing: -0.2,
        ),
        iconTheme: const IconThemeData(color: AppColors.primary),
      ),
      cardTheme: CardThemeData(
        color: tc.card,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
          side: BorderSide(color: tc.border),
        ),
      ),
      dividerTheme: DividerThemeData(
        color: tc.border,
        thickness: 1,
        space: 1,
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) => Colors.white),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return AppColors.primary;
          return tc.border;
        }),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: tc.card,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: tc.card,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
        ),
      ),
      textTheme: TextTheme(
        headlineLarge: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w700,
          color: tc.textPrimary,
          letterSpacing: -0.6,
        ),
        titleLarge: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: tc.textPrimary,
          letterSpacing: -0.4,
        ),
        titleMedium: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w600,
          color: tc.textPrimary,
          letterSpacing: -0.2,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          color: tc.textPrimary,
          height: 1.45,
        ),
        bodyMedium: TextStyle(
          fontSize: 15,
          color: tc.textSecondary,
          height: 1.45,
        ),
        bodySmall: TextStyle(
          fontSize: 13,
          color: tc.textMuted,
          height: 1.35,
        ),
        labelLarge: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: AppColors.primary,
        ),
      ),
      cupertinoOverrideTheme: CupertinoThemeData(
        primaryColor: AppColors.primary,
        barBackgroundColor: tc.card,
        scaffoldBackgroundColor: tc.background,
      ),
    );
  }

  static ThemeData dark() {
    final tc = AppThemeColors.dark;
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: tc.background,
      canvasColor: tc.background,
      dividerColor: tc.border,
      splashColor: AppColors.primary.withValues(alpha: 0.12),
      highlightColor: AppColors.primary.withValues(alpha: 0.08),
      colorScheme: ColorScheme.dark(
        primary: AppColors.primary,
        secondary: AppColors.primary,
        surface: tc.card,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: tc.textPrimary,
      ),
      extensions: const [AppThemeColors.dark],
      appBarTheme: AppBarTheme(
        backgroundColor: tc.card,
        foregroundColor: tc.textPrimary,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        surfaceTintColor: Colors.transparent,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
        ),
        titleTextStyle: TextStyle(
          color: tc.textPrimary,
          fontSize: 17,
          fontWeight: FontWeight.w600,
          letterSpacing: -0.2,
        ),
        iconTheme: const IconThemeData(color: AppColors.primary),
      ),
      cardTheme: CardThemeData(
        color: tc.card,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
          side: BorderSide(color: tc.border),
        ),
      ),
      dividerTheme: DividerThemeData(
        color: tc.border,
        thickness: 1,
        space: 1,
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) => Colors.white),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return AppColors.primary;
          return tc.border;
        }),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: tc.card,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: tc.card,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
        ),
      ),
      textTheme: TextTheme(
        headlineLarge: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w700,
          color: tc.textPrimary,
          letterSpacing: -0.6,
        ),
        titleLarge: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: tc.textPrimary,
          letterSpacing: -0.4,
        ),
        titleMedium: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w600,
          color: tc.textPrimary,
          letterSpacing: -0.2,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          color: tc.textPrimary,
          height: 1.45,
        ),
        bodyMedium: TextStyle(
          fontSize: 15,
          color: tc.textSecondary,
          height: 1.45,
        ),
        bodySmall: TextStyle(
          fontSize: 13,
          color: tc.textMuted,
          height: 1.35,
        ),
        labelLarge: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: AppColors.primary,
        ),
      ),
      cupertinoOverrideTheme: CupertinoThemeData(
        primaryColor: AppColors.primary,
        barBackgroundColor: tc.card,
        scaffoldBackgroundColor: tc.background,
      ),
    );
  }
}
