import 'package:flutter/material.dart';

class ToolItem {
  const ToolItem({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.iconBg,
    required this.accent,
  });

  final String id;
  final String title;
  final String description;
  final IconData icon;
  final Color iconBg;
  final Color accent;
}
