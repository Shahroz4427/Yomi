import 'package:yomi/data/models/anime_banner.dart';
import 'package:yomi/data/models/anime_details.dart';
import 'package:yomi/data/models/anime_item.dart';
import 'package:yomi/data/models/browse_category.dart';
import 'package:yomi/data/models/top_category.dart';

/// Where the UI gets anime catalogue data from.
///
/// Screens depend on this interface only, never on a concrete data source.
/// Today `StaticAnimeRepository` returns dummy data. When the REST API is
/// ready, add an API-backed implementation and swap it in `main.dart`.
///
/// The methods are synchronous because the data is local. A remote
/// implementation will make them return `Future<...>`; that change stays
/// inside the repository and the data-loading line of each screen.
abstract interface class AnimeRepository {
  List<AnimeBanner> getBanners();

  List<AnimeItem> getCurrentlyAiring();

  List<AnimeItem> getTrendingNow();

  List<AnimeItem> getAllTimePopular();

  List<AnimeItem> getComingNextSeason();

  List<AnimeItem> getTopCompletedSeries();

  /// Anime for the Browse screen, ordered / grouped by [category].
  List<AnimeItem> getBrowseAnime(BrowseCategory category);

  /// Ranked anime for the Top screen.
  List<AnimeItem> getTopAnime(TopCategory category);

  /// Every anime once, without duplicates.
  List<AnimeItem> getAllAnime();

  /// Anime whose title contains [query] (case insensitive).
  List<AnimeItem> searchAnime(String query);

  /// Synopsis, genres and episodes for the details and player screens.
  AnimeDetails getAnimeDetails(AnimeItem anime);
}
