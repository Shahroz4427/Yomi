import 'package:yomi/data/anime_data.dart';
import 'package:yomi/model/anime_item.dart';

/// Helper data class for browse screen categories and filtering.
class BrowseCategoryData {

  static const List<String> categories = [
    'Most Popular',
    'Trending Now',
    'Highest Rated',
    'Newest First',
    'Most Episodes',
  ];

  static const List<String> kBrowseCategories = categories;

  /// Returns the anime list that belongs to [category].
  static List<AnimeItem> animeForCategory(String category) {
    final anime = List<AnimeItem>.from(AnimeData.allBrowseAnimes);

    switch (category) {
      case 'Most Popular':
        return AnimeData.allTimePopularAnimes;

      case 'Trending Now':
        return AnimeData.trendingNowAnimes;

      case 'Highest Rated':
        anime.sort((a, b) => b.rating.compareTo(a.rating));
        return anime;

      case 'Most Episodes':
        anime.sort((a, b) => _episodeCount(b).compareTo(_episodeCount(a)));
        return anime;

      case 'Newest First':
        return AnimeData.comingNextSeasonAnimes;

      default:
        return anime;
    }
  }

  // "24 eps" -> 24. Falls back to 0 when the text is not a number.
  static int _episodeCount(AnimeItem anime) {
    return int.tryParse(anime.episodes.split(' ').first) ?? 0;
  }

}
