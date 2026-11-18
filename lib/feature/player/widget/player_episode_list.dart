import 'package:flutter/material.dart';
import 'package:yomi/core/theme/app_theme.dart';
import 'package:yomi/data/models/episode.dart';
import 'package:yomi/shared/widgets/episode_tile.dart';
import 'package:yomi/shared/widgets/section_title.dart';

/// Below the video: anime title, current episode and all episodes.
class PlayerEpisodeList extends StatelessWidget {
  const PlayerEpisodeList({
    super.key,
    required this.animeTitle,
    required this.posterPath,
    required this.episodes,
    required this.currentIndex,
    required this.onEpisodeTap,
  });

  final String animeTitle;
  final String posterPath;
  final List<Episode> episodes;
  final int currentIndex;
  final ValueChanged<int> onEpisodeTap;

  @override
  Widget build(BuildContext context) {
    final current = episodes[currentIndex];

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      children: [
        Text(
          animeTitle,
          style: const TextStyle(
            color: AppTheme.primaryTextColor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Episode ${current.number}  ·  ${current.title}',
          style: const TextStyle(
            color: AppTheme.secondaryTextColor,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 22),
        const SectionTitle('Episodes'),
        const SizedBox(height: 12),
        for (var index = 0; index < episodes.length; index++)
          EpisodeTile(
            episode: episodes[index],
            thumbnail: posterPath,
            isPlaying: index == currentIndex,
            onTap: () => onEpisodeTap(index),
          ),
      ],
    );
  }
}
