import 'package:flutter/material.dart';
import 'package:yomi/core/theme/app_theme.dart';
import 'package:yomi/shared/widgets/arrow_button.dart';

/// Heading row of an anime list: icon, title, "View all" and scroll arrows.
class AnimeCardListHeader extends StatelessWidget {
  const AnimeCardListHeader({
    super.key,
    required this.title,
    required this.icon,
    required this.iconColor,
    required this.canScrollLeft,
    required this.canScrollRight,
    required this.onViewAll,
    required this.onScrollLeft,
    required this.onScrollRight,
  });

  final String title;
  final IconData icon;
  final Color iconColor;
  final bool canScrollLeft;
  final bool canScrollRight;
  final VoidCallback onViewAll;
  final VoidCallback onScrollLeft;
  final VoidCallback onScrollRight;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        children: [
          Icon(icon, color: iconColor, size: 22),
          const SizedBox(width: 5),
          Expanded(
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          TextButton(
            onPressed: onViewAll,
            style: TextButton.styleFrom(
              foregroundColor: AppTheme.accentColor,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              minimumSize: const Size(0, 36),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('View all', style: TextStyle(color: Colors.white)),
                SizedBox(width: 3),
                Icon(
                  Icons.chevron_right_rounded,
                  size: 17,
                  color: Colors.white,
                ),
              ],
            ),
          ),
          const SizedBox(width: 4),
          ArrowButton(
            icon: Icons.chevron_left_rounded,
            enabled: canScrollLeft,
            onTap: onScrollLeft,
          ),
          const SizedBox(width: 6),
          ArrowButton(
            icon: Icons.chevron_right_rounded,
            enabled: canScrollRight,
            onTap: onScrollRight,
          ),
        ],
      ),
    );
  }
}
