import 'package:yomi/data/models/anime_item.dart';
import 'package:yomi/data/models/my_list_entry.dart';
import 'package:yomi/data/repositories/my_list_repository.dart';
import 'package:yomi/data/sources/static_anime_data.dart';

/// [MyListRepository] backed by dummy data (UI development phase).
class StaticMyListRepository implements MyListRepository {
  const StaticMyListRepository();

  static const List<MyListStatus> _statuses = [
    MyListStatus.watching,
    MyListStatus.planToWatch,
    MyListStatus.completed,
    MyListStatus.onHold,
    MyListStatus.watching,
    MyListStatus.dropped,
  ];

  static const List<int> _watchedEpisodes = [8, 0, 24, 5, 12, 3];

  @override
  List<MyListEntry> getMyList() {
    final animes = StaticAnimeData.allTimePopularAnimes;

    return [
      for (var index = 0; index < animes.length; index++)
        MyListEntry(
          anime: animes[index],
          status: _statuses[index % _statuses.length],
          watchedEpisodes: _watchedEpisodes[index % _watchedEpisodes.length],
          totalEpisodes: _totalEpisodes(animes[index]),
        ),
    ];
  }

  // "25 ep" -> 25. Falls back to 12 when no number is found.
  int _totalEpisodes(AnimeItem anime) {
    final digits = RegExp(r'\d+').firstMatch(anime.episodes)?.group(0) ?? '';

    return int.tryParse(digits) ?? 12;
  }
}
