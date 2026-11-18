import 'package:yomi/data/models/anime_item.dart';
import 'package:yomi/data/models/episode.dart';

/// Everything shown on the anime details screen.
class AnimeDetails {
  final AnimeItem anime;
  final String synopsis;
  final List<String> genres;
  final String studio;
  final String status;
  final String releaseYear;
  final List<Episode> episodes;

  const AnimeDetails({
    required this.anime,
    required this.synopsis,
    required this.genres,
    required this.studio,
    required this.status,
    required this.releaseYear,
    required this.episodes,
  });
}
