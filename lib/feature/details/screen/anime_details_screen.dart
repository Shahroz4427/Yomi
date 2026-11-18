import 'package:flutter/material.dart';
import 'package:yomi/data/models/anime_details.dart';
import 'package:yomi/data/models/anime_item.dart';
import 'package:yomi/data/repositories/anime_repository.dart';
import 'package:yomi/feature/details/widget/details_actions.dart';
import 'package:yomi/feature/details/widget/details_episodes.dart';
import 'package:yomi/feature/details/widget/details_genres.dart';
import 'package:yomi/feature/details/widget/details_hero.dart';
import 'package:yomi/feature/details/widget/details_info_card.dart';
import 'package:yomi/feature/details/widget/details_synopsis.dart';
import 'package:yomi/feature/details/widget/details_title_block.dart';
import 'package:yomi/feature/player/video_player_navigation.dart';
import 'package:yomi/shared/widgets/section_title.dart';

/// Poster, summary, genres and episode list of one anime.
class AnimeDetailsScreen extends StatefulWidget {
  const AnimeDetailsScreen({
    super.key,
    required this.anime,
    required this.repository,
  });

  final AnimeItem anime;
  final AnimeRepository repository;

  @override
  State<AnimeDetailsScreen> createState() => _AnimeDetailsScreenState();
}

class _AnimeDetailsScreenState extends State<AnimeDetailsScreen> {
  late final AnimeDetails _details = widget.repository.getAnimeDetails(
    widget.anime,
  );

  // Local only for now; saving to the user's list needs the API.
  bool _isInList = false;

  void _play(int episodeIndex) {
    openVideoPlayer(
      context,
      animeTitle: widget.anime.title,
      posterPath: widget.anime.image,
      episodes: _details.episodes,
      initialIndex: episodeIndex,
    );
  }

  void _toggleList() {
    setState(() => _isInList = !_isInList);

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            _isInList ? 'Added to My List' : 'Removed from My List',
          ),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    final anime = widget.anime;

    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          DetailsHero(
            image: anime.image,
            onBack: () => Navigator.pop(context),
            onPlay: () => _play(0),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DetailsTitleBlock(details: _details),
                const SizedBox(height: 18),
                DetailsActions(
                  isInList: _isInList,
                  onWatch: () => _play(0),
                  onToggleList: _toggleList,
                ),
                const SizedBox(height: 24),
                const SectionTitle('Synopsis'),
                const SizedBox(height: 10),
                DetailsSynopsis(text: _details.synopsis),
                const SizedBox(height: 24),
                const SectionTitle('Genres'),
                const SizedBox(height: 12),
                DetailsGenres(genres: _details.genres),
                const SizedBox(height: 24),
                const SectionTitle('Information'),
                const SizedBox(height: 12),
                DetailsInfoCard(details: _details),
                const SizedBox(height: 24),
                const SectionTitle('Episodes'),
                const SizedBox(height: 12),
                DetailsEpisodes(
                  episodes: _details.episodes,
                  thumbnail: anime.image,
                  onEpisodeTap: _play,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
