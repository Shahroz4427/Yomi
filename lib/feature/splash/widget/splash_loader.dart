import 'package:flutter/material.dart';
import 'package:yomi/core/theme/app_theme.dart';

/// Circular progress indicator with a caption.
class SplashLoader extends StatelessWidget {
  const SplashLoader({super.key, required this.fade});

  final Animation<double> fade;

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: fade,
      child: Column(
        children: [
          const SizedBox(
            width: 35,
            height: 35,
            child: CircularProgressIndicator(
              strokeWidth: 2.5,
              color: AppTheme.secondaryColor,
              backgroundColor: Colors.white12,
            ),
          ),
          const SizedBox(height: 18),
          Text(
            'PREPARING YOUR EXPERIENCE',
            style: TextStyle(
              fontSize: 9,
              letterSpacing: 2,
              fontWeight: FontWeight.w500,
              color: Colors.white.withValues(alpha: 0.4),
            ),
          ),
        ],
      ),
    );
  }
}
