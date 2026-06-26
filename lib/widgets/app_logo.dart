import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key, this.size = 72});

  final double size;

  static const _assetPath = 'assets/app_icon.png';

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(size * 0.22),
      child: Image.asset(
        _assetPath,
        width: size,
        height: size,
        fit: BoxFit.cover,
      ),
    );
  }
}

class AppLogoSmall extends StatelessWidget {
  const AppLogoSmall({super.key, this.size = 28});

  final double size;

  @override
  Widget build(BuildContext context) {
    return AppLogo(size: size);
  }
}
