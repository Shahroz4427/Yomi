import 'package:flutter/material.dart';

/// Branding line at the bottom of the splash screen.
class SplashFooter extends StatelessWidget {
  const SplashFooter({super.key, required this.fade});

  final Animation<double> fade;

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: fade,
      child: Text(
        'MADE FOR ANIME FANS',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 9,
          letterSpacing: 2,
          color: Colors.white.withValues(alpha: 0.3),
        ),
      ),
    );
  }
}
