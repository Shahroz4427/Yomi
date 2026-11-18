import 'package:flutter/material.dart';

/// "Trending Searches" heading with tappable pills.
class TrendingSearches extends StatelessWidget {
  const TrendingSearches({super.key, required this.onSelected});

  final ValueChanged<String> onSelected;

  static const List<String> _searches = [
    'Solo Leveling',
    'Demon Slayer',
    'Jujutsu Kaisen',
    'One Piece',
    'Attack on Titan',
    'Naruto',
    'Blue Lock',
    'Chainsaw Man',
    'My Hero Academia',
    'Frieren',
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.trending_up_rounded, color: colors.primary, size: 20),
              const SizedBox(width: 7),
              Text(
                'Trending Searches',
                style: theme.textTheme.titleMedium?.copyWith(fontSize: 15),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 8,
            runSpacing: 10,
            children: [
              for (final search in _searches)
                InkWell(
                  onTap: () => onSelected(search),
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 9,
                    ),
                    decoration: BoxDecoration(
                      color: colors.surface,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: colors.primary.withValues(alpha: 0.25),
                      ),
                    ),
                    child: Text(
                      search,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colors.onSurface,
                        fontWeight: FontWeight.w600,
                        fontSize: 11,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
