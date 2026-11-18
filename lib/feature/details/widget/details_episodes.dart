import 'package:flutter/material.dart';
import 'package:yomi/data/models/episode.dart';
import 'package:yomi/shared/widgets/episode_tile.dart';

/// Column of episode tiles. Tapping one reports its index.
class DetailsEpisodes extends StatelessWidget {
  const DetailsEpisodes({
    super.key,
    required this.episodes,
    required this.thumbnail,
    required this.onEpisodeTap,
  });

  final List<Episode> episodes;
  final String thumbnail;
  final ValueChanged<int> onEpisodeTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var index = 0; index < episodes.length; index++)
          EpisodeTile(
            episode: episodes[index],
            thumbnail: thumbnail,
            onTap: () => onEpisodeTap(index),
          ),
      ],
    );
  }
}
