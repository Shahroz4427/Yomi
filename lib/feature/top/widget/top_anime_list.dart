import 'package:flutter/material.dart';
import 'package:yomi/core/theme/app_theme.dart';
import 'package:yomi/data/models/anime_item.dart';
import 'package:yomi/feature/top/widget/top_anime_tile.dart';

/// Ranked list of anime, or an empty message when there is nothing to show.
class TopAnimeList extends StatelessWidget {
  const TopAnimeList({super.key, required this.animes, required this.onAnimeTap});

  final List<AnimeItem> animes;
  final ValueChanged<AnimeItem> onAnimeTap;

  @override
  Widget build(BuildContext context) {
    if (animes.isEmpty) {
      return const Center(
        child: Text(
          'No anime available',
          style: TextStyle(color: AppTheme.secondaryTextColor),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(12, 0, 12, 20),
      itemCount: animes.length,
      itemBuilder: (context, index) {
        final anime = animes[index];

        return TopAnimeTile(
          anime: anime,
          rank: index + 1,
          onTap: () => onAnimeTap(anime),
        );
      },
    );
  }
}
