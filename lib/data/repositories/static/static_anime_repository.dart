import 'package:yomi/data/models/anime_banner.dart';
import 'package:yomi/data/models/anime_details.dart';
import 'package:yomi/data/models/anime_item.dart';
import 'package:yomi/data/models/browse_category.dart';
import 'package:yomi/data/models/episode.dart';
import 'package:yomi/data/models/top_category.dart';
import 'package:yomi/data/repositories/anime_repository.dart';
import 'package:yomi/data/sources/static_anime_data.dart';
import 'package:yomi/data/sources/static_banner_data.dart';
import 'package:yomi/data/sources/static_video_data.dart';

/// [AnimeRepository] backed by the built-in dummy data (UI development phase).
class StaticAnimeRepository implements AnimeRepository {
  const StaticAnimeRepository();

  @override
  List<AnimeBanner> getBanners() => StaticBannerData.banners;

  @override
  List<AnimeItem> getCurrentlyAiring() => StaticAnimeData.currentlyAiringAnimes;

  @override
  List<AnimeItem> getTrendingNow() => StaticAnimeData.trendingNowAnimes;

  @override
  List<AnimeItem> getAllTimePopular() => StaticAnimeData.allTimePopularAnimes;

  @override
  List<AnimeItem> getComingNextSeason() {
    return StaticAnimeData.comingNextSeasonAnimes;
  }

  @override
  List<AnimeItem> getTopCompletedSeries() {
    return StaticAnimeData.topCompletedSeriesAnimes;
  }

  @override
  List<AnimeItem> getBrowseAnime(BrowseCategory category) {
    switch (category) {
      case BrowseCategory.mostPopular:
        return StaticAnimeData.allTimePopularAnimes;

      case BrowseCategory.trendingNow:
        return StaticAnimeData.trendingNowAnimes;

      case BrowseCategory.highestRated:
        return _allAnimeSortedBy((a, b) => b.rating.compareTo(a.rating));

      case BrowseCategory.mostEpisodes:
        return _allAnimeSortedBy(
          (a, b) => _episodeCount(b).compareTo(_episodeCount(a)),
        );

      case BrowseCategory.newestFirst:
        return StaticAnimeData.comingNextSeasonAnimes;
    }
  }

  @override
  List<AnimeItem> getTopAnime(TopCategory category) {
    // Temporary: every category shows the same list. Real ranking and
    // filtering will come from the API.
    return StaticAnimeData.allTimePopularAnimes;
  }

  @override
  List<AnimeItem> getAllAnime() => _distinct(StaticAnimeData.allBrowseAnimes);

  @override
  List<AnimeItem> searchAnime(String query) {
    final text = query.trim().toLowerCase();

    if (text.isEmpty) return const [];

    return getAllAnime()
        .where((anime) => anime.title.toLowerCase().contains(text))
        .toList();
  }

  @override
  AnimeDetails getAnimeDetails(AnimeItem anime) {
    final isMovie = anime.type == 'Movie';
    final episodeCount = isMovie ? 1 : _playableEpisodeCount(anime);

    return AnimeDetails(
      anime: anime,
      synopsis:
          'A story full of action, friendship and unexpected twists. '
          '${anime.title} follows a group of unlikely heroes as they face '
          'powerful enemies, uncover long-buried secrets and discover what '
          'they are truly capable of.\n\n'
          'Every step forward costs them something, and the closer they get '
          'to the truth, the harder it becomes to tell allies from rivals.',
      genres: _genresFor(anime),
      studio: 'Yomi Demo Studio',
      status: isMovie ? 'Completed' : 'Ongoing',
      releaseYear: '2024',
      // Every episode streams the same demo video for now.
      episodes: [
        for (var number = 1; number <= episodeCount; number++)
          Episode(
            number: number,
            title: isMovie ? anime.title : 'Episode $number',
            duration: isMovie ? '1h 30m' : '24 min',
            videoUrl: StaticVideoData.demoVideoUrl,
          ),
      ],
    );
  }

  // Keeps the same anime from appearing twice (e.g. in two home sections).
  List<AnimeItem> _distinct(Iterable<AnimeItem> items) {
    final seenTitles = <String>{};

    return [
      for (final anime in items)
        if (seenTitles.add(anime.title)) anime,
    ];
  }

  // "25 ep" -> 25, limited to 24 so the demo episode list stays short.
  int _playableEpisodeCount(AnimeItem anime) {
    final digits = RegExp(r'\d+').firstMatch(anime.episodes)?.group(0) ?? '';
    final count = int.tryParse(digits) ?? 12;

    return count.clamp(1, 24).toInt();
  }

  List<String> _genresFor(AnimeItem anime) {
    const genreSets = [
      ['Action', 'Adventure', 'Fantasy'],
      ['Drama', 'Mystery', 'Thriller'],
      ['Comedy', 'Slice of Life'],
      ['Sci-Fi', 'Action'],
    ];

    return genreSets[anime.title.length % genreSets.length];
  }

  List<AnimeItem> _allAnimeSortedBy(
    int Function(AnimeItem a, AnimeItem b) compare,
  ) {
    return List<AnimeItem>.from(StaticAnimeData.allBrowseAnimes)..sort(compare);
  }

  // "24 ep" -> 24. Falls back to 0 when the text is not a number.
  int _episodeCount(AnimeItem anime) {
    return int.tryParse(anime.episodes.split(' ').first) ?? 0;
  }
}
