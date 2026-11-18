import 'package:yomi/data/models/anime_banner.dart';
import 'package:yomi/data/models/anime_item.dart';
import 'package:yomi/data/models/browse_category.dart';
import 'package:yomi/data/models/top_category.dart';
import 'package:yomi/data/repositories/anime_repository.dart';
import 'package:yomi/data/sources/static_anime_data.dart';
import 'package:yomi/data/sources/static_banner_data.dart';

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
