import 'package:flutter/material.dart';

/// Prominent dark/light mode toggle for the home hero header.
class ThemeToggleButton extends StatelessWidget {
  const ThemeToggleButton({
    super.key,
    required this.isDarkMode,
    required this.onPressed,
  });

  final bool isDarkMode;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: isDarkMode ? 'Switch to light mode' : 'Switch to dark mode',
      child: Material(
        color: Colors.white.withValues(alpha: 0.22),
        borderRadius: BorderRadius.circular(14),
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(14),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  isDarkMode ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
                  color: Colors.white,
                  size: 22,
                ),
                const SizedBox(width: 6),
                Text(
                  isDarkMode ? 'Light' : 'Dark',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
