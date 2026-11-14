import 'package:flutter/material.dart';

/// "Browse Anime" title row with the number of visible titles.
class BrowseHeader extends StatelessWidget {
  const BrowseHeader({super.key, required this.titleCount});

  final int titleCount;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Icon(
          Icons.grid_view_rounded,
          color: theme.colorScheme.secondary,
          size: 21,
        ),
        const SizedBox(width: 9),
        Text(
          'Browse Anime',
          style: theme.textTheme.titleLarge?.copyWith(
            fontSize: 19,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Spacer(),
        Text(
          '$titleCount titles',
          style: theme.textTheme.bodySmall?.copyWith(fontSize: 11),
        ),
      ],
    );
  }
}