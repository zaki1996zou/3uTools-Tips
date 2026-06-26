import 'package:flutter/material.dart';

enum TutorialDifficulty { beginner, intermediate, advanced, fixes }

class TutorialStep {
  const TutorialStep({
    required this.title,
    required this.description,
  });

  final String title;
  final String description;
}

class Tutorial {
  const Tutorial({
    required this.id,
    required this.title,
    required this.category,
    required this.difficulty,
    required this.durationMinutes,
    required this.rating,
    required this.icon,
    required this.subtitle,
    required this.steps,
    required this.proTips,
  });

  final String id;
  final String title;
  final String category;
  final TutorialDifficulty difficulty;
  final int durationMinutes;
  final double rating;
  final IconData icon;
  final String subtitle;
  final List<TutorialStep> steps;
  final List<String> proTips;

  String get difficultyLabel {
    switch (difficulty) {
      case TutorialDifficulty.beginner:
        return 'Beginner';
      case TutorialDifficulty.intermediate:
        return 'Intermediate';
      case TutorialDifficulty.advanced:
        return 'Advanced';
      case TutorialDifficulty.fixes:
        return 'Fixes';
    }
  }
}
