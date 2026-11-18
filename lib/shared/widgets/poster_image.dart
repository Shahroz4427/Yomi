import 'package:flutter/material.dart';
import 'package:yomi/core/theme/app_theme.dart';

/// Rounded anime poster with a placeholder when the image cannot be loaded.
class PosterImage extends StatelessWidget {
  const PosterImage({
    super.key,
    required this.path,
    required this.width,
    required this.height,
    this.borderRadius = 10,
  });

  final String path;
  final double width;
  final double height;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Image.asset(
        path,
        width: width,
        height: height,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: width,
            height: height,
            color: AppTheme.backgroundColor,
            child: const Icon(
              Icons.image_not_supported_outlined,
              color: AppTheme.secondaryTextColor,
            ),
          );
        },
      ),
    );
  }
}
