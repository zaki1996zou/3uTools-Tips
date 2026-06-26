import 'package:flutter/material.dart';

@immutable
class AppThemeColors extends ThemeExtension<AppThemeColors> {
  const AppThemeColors({
    required this.background,
    required this.card,
    required this.border,
    required this.textPrimary,
    required this.textSecondary,
    required this.textMuted,
    required this.secondaryTint,
    required this.secondarySoft,
    required this.secondaryMuted,
    required this.proTipBg,
    required this.proTipBorder,
    required this.searchFieldBg,
    required this.statBlockBg,
    required this.pillSurface,
    required this.dockActiveBg,
    required this.inputFill,
  });

  final Color background;
  final Color card;
  final Color border;
  final Color textPrimary;
  final Color textSecondary;
  final Color textMuted;
  final Color secondaryTint;
  final Color secondarySoft;
  final Color secondaryMuted;
  final Color proTipBg;
  final Color proTipBorder;
  final Color searchFieldBg;
  final Color statBlockBg;
  final Color pillSurface;
  final Color dockActiveBg;
  final Color inputFill;

  static const light = AppThemeColors(
    background: Color(0xFFF7FAFF),
    card: Color(0xFFFFFFFF),
    border: Color(0xFFE2E9F0),
    textPrimary: Color(0xFF363C49),
    textSecondary: Color(0xFF6B7585),
    textMuted: Color(0xFF9AA3B2),
    secondaryTint: Color(0xFFDCE6F5),
    secondarySoft: Color(0xFFEDF2FA),
    secondaryMuted: Color(0xFFF3F7FC),
    proTipBg: Color(0xFFEDF2FA),
    proTipBorder: Color(0xFF366DDC),
    searchFieldBg: Color(0xFFFFFFFF),
    statBlockBg: Color(0xEBFFFFFF),
    pillSurface: Color(0xFFFFFFFF),
    dockActiveBg: Color(0xFFFFFFFF),
    inputFill: Color(0xFFFFFFFF),
  );

  static const dark = AppThemeColors(
    background: Color(0xFF0F1419),
    card: Color(0xFF1A2230),
    border: Color(0xFF2A3544),
    textPrimary: Color(0xFFE8ECF2),
    textSecondary: Color(0xFFA8B2C2),
    textMuted: Color(0xFF7A8699),
    secondaryTint: Color(0xFF243044),
    secondarySoft: Color(0xFF1E2838),
    secondaryMuted: Color(0xFF222D3D),
    proTipBg: Color(0xFF1E2838),
    proTipBorder: Color(0xFF3D5F9E),
    searchFieldBg: Color(0xFFFFFFFF),
    statBlockBg: Color(0xF21A2230),
    pillSurface: Color(0xFF1A2230),
    dockActiveBg: Color(0xFFFFFFFF),
    inputFill: Color(0xFF243044),
  );

  @override
  AppThemeColors copyWith({
    Color? background,
    Color? card,
    Color? border,
    Color? textPrimary,
    Color? textSecondary,
    Color? textMuted,
    Color? secondaryTint,
    Color? secondarySoft,
    Color? secondaryMuted,
    Color? proTipBg,
    Color? proTipBorder,
    Color? searchFieldBg,
    Color? statBlockBg,
    Color? pillSurface,
    Color? dockActiveBg,
    Color? inputFill,
  }) {
    return AppThemeColors(
      background: background ?? this.background,
      card: card ?? this.card,
      border: border ?? this.border,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      textMuted: textMuted ?? this.textMuted,
      secondaryTint: secondaryTint ?? this.secondaryTint,
      secondarySoft: secondarySoft ?? this.secondarySoft,
      secondaryMuted: secondaryMuted ?? this.secondaryMuted,
      proTipBg: proTipBg ?? this.proTipBg,
      proTipBorder: proTipBorder ?? this.proTipBorder,
      searchFieldBg: searchFieldBg ?? this.searchFieldBg,
      statBlockBg: statBlockBg ?? this.statBlockBg,
      pillSurface: pillSurface ?? this.pillSurface,
      dockActiveBg: dockActiveBg ?? this.dockActiveBg,
      inputFill: inputFill ?? this.inputFill,
    );
  }

  @override
  AppThemeColors lerp(ThemeExtension<AppThemeColors>? other, double t) {
    if (other is! AppThemeColors) return this;
    return AppThemeColors(
      background: Color.lerp(background, other.background, t)!,
      card: Color.lerp(card, other.card, t)!,
      border: Color.lerp(border, other.border, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      textMuted: Color.lerp(textMuted, other.textMuted, t)!,
      secondaryTint: Color.lerp(secondaryTint, other.secondaryTint, t)!,
      secondarySoft: Color.lerp(secondarySoft, other.secondarySoft, t)!,
      secondaryMuted: Color.lerp(secondaryMuted, other.secondaryMuted, t)!,
      proTipBg: Color.lerp(proTipBg, other.proTipBg, t)!,
      proTipBorder: Color.lerp(proTipBorder, other.proTipBorder, t)!,
      searchFieldBg: Color.lerp(searchFieldBg, other.searchFieldBg, t)!,
      statBlockBg: Color.lerp(statBlockBg, other.statBlockBg, t)!,
      pillSurface: Color.lerp(pillSurface, other.pillSurface, t)!,
      dockActiveBg: Color.lerp(dockActiveBg, other.dockActiveBg, t)!,
      inputFill: Color.lerp(inputFill, other.inputFill, t)!,
    );
  }
}

extension AppThemeColorsContext on BuildContext {
  AppThemeColors get tc => Theme.of(this).extension<AppThemeColors>()!;
}
