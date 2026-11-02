
import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  static const List<String> trendingSearches = [
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

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: TextField(
          autofocus: true,
          cursorColor: colors.primary,
          style: theme.textTheme.bodyLarge,
          decoration: InputDecoration(
            hintText: 'Search anime...',
            hintStyle: theme.textTheme.bodyMedium,
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            filled: false,
            contentPadding: EdgeInsets.zero,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Trending heading
            Row(
              children: [
                Icon(
                  Icons.trending_up_rounded,
                  color: colors.primary,
                  size: 20,
                ),
                const SizedBox(width: 7),
                Text(
                  'Trending Searches',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontSize: 15,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 14),

            // Trending search pills
            Wrap(
              spacing: 8,
              runSpacing: 10,
              children: trendingSearches.map((anime) {
                return InkWell(
                  onTap: () {
                    debugPrint('Selected: $anime');
                  },
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
                      anime,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colors.onSurface,
                        fontWeight: FontWeight.w600,
                        fontSize: 11,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
