import 'package:flutter/material.dart';
import 'package:yomi/core/theme/app_theme.dart';
import 'package:yomi/data/models/top_category.dart';

/// One selectable category pill with an icon.
class TopCategoryChip extends StatelessWidget {
  const TopCategoryChip({
    super.key,
    required this.category,
    required this.isSelected,
    required this.onTap,
  });

  final TopCategory category;
  final bool isSelected;
  final VoidCallback onTap;

  IconData get _icon {
    return switch (category) {
      TopCategory.mostPopular => Icons.local_fire_department_rounded,
      TopCategory.topRated => Icons.star_outline_rounded,
      TopCategory.trending => Icons.trending_up_rounded,
      TopCategory.topMovies => Icons.movie_outlined,
      TopCategory.topTv => Icons.tv_outlined,
    };
  }

  @override
  Widget build(BuildContext context) {
    final contentColor = isSelected
        ? Colors.white
        : AppTheme.secondaryTextColor;

    return InkWell(
      borderRadius: BorderRadius.circular(30),
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 11),
        decoration: BoxDecoration(
          gradient: isSelected
              ? LinearGradient(
                  colors: [
                    AppTheme.primaryColor,
                    AppTheme.primaryColor.withValues(alpha: 0.75),
                  ],
                )
              : null,
          color: isSelected ? null : AppTheme.surfaceColor,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: isSelected ? AppTheme.secondaryColor : AppTheme.borderColor,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppTheme.primaryColor.withValues(alpha: 0.25),
                    blurRadius: 12,
                    spreadRadius: 1,
                  ),
                ]
              : [],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(_icon, size: 16, color: contentColor),
            const SizedBox(width: 7),
            Text(
              category.label,
              style: TextStyle(
                color: contentColor,
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
