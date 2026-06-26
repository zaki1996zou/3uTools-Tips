import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_theme_colors.dart';

abstract final class AppStyles {
  static const radiusSm = 10.0;
  static const radiusMd = 14.0;
  static const radiusLg = 20.0;
  static const radiusXl = 28.0;

  static BoxDecoration card(BuildContext context, {Color? color, double radius = radiusLg}) {
    final tc = context.tc;
    return BoxDecoration(
      color: color ?? tc.card,
      borderRadius: BorderRadius.circular(radius),
      border: Border.all(color: tc.border),
    );
  }

  static BoxDecoration bluePanel(BuildContext context, {double radius = radiusLg}) {
    final tc = context.tc;
    return BoxDecoration(
      color: tc.secondaryTint,
      borderRadius: BorderRadius.circular(radius),
      border: Border.all(color: AppColors.secondary.withValues(alpha: 0.35)),
    );
  }

  static const heroTitle = TextStyle(
    fontSize: 26,
    fontWeight: FontWeight.w800,
    color: AppColors.textOnBlue,
    letterSpacing: -0.5,
    height: 1.1,
  );

  static TextStyle pageTitle(BuildContext context) => TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w800,
        color: context.tc.textPrimary,
        letterSpacing: -0.5,
      );

  static const sectionLabel = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w700,
    color: AppColors.secondary,
    letterSpacing: 0.6,
  );

  static TextStyle body(BuildContext context) => TextStyle(
        fontSize: 15,
        color: context.tc.textSecondary,
        height: 1.45,
      );

  static TextStyle caption(BuildContext context) => TextStyle(
        fontSize: 13,
        color: context.tc.textMuted,
        height: 1.35,
      );

  static LinearGradient get heroGradient => const LinearGradient(
        colors: [Color(0xFF2B57B8), AppColors.secondary],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );

  static LinearGradient get heroGradientDeep => const LinearGradient(
        colors: [Color(0xFF244BA8), AppColors.secondary],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      );

  static LinearGradient get accentGradient => const LinearGradient(
        colors: [Color(0xFF2B57B8), AppColors.secondary],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      );
}
