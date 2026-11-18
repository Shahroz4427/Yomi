import 'package:flutter/material.dart';
import 'package:yomi/core/constants/app_assets.dart';
import 'package:yomi/core/theme/app_theme.dart';

/// App logo that fades and scales in with a soft glow.
class SplashLogo extends StatelessWidget {
  const SplashLogo({super.key, required this.fade, required this.scale});

  final Animation<double> fade;
  final Animation<double> scale;

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: fade,
      child: ScaleTransition(
        scale: scale,
        child: Container(
          height: 150,
          width: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(35),
            boxShadow: [
              BoxShadow(
                color: AppTheme.primaryColor.withValues(alpha: 0.3),
                blurRadius: 70,
                spreadRadius: 5,
              ),
            ],
          ),
          child: Image.asset(AppAssets.logo, fit: BoxFit.contain),
        ),
      ),
    );
  }
}
