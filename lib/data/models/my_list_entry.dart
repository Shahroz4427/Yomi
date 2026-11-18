import 'package:yomi/data/models/anime_item.dart';

/// The user's watching state for an anime in "My List".
///
/// The declaration order is the order used by the My List filter chips.
enum MyListStatus {
  watching('Watching'),
  planToWatch('Plan to Watch'),
  completed('Completed'),
  onHold('On Hold'),
  dropped('Dropped');

  const MyListStatus(this.label);

  /// Text shown in the UI.
  final String label;
}

/// An anime saved in the user's list together with their progress.
class MyListEntry {
  final AnimeItem anime;
  final MyListStatus status;
  final int watchedEpisodes;
  final int totalEpisodes;

  const MyListEntry({
    required this.anime,
    required this.status,
    required this.watchedEpisodes,
    required this.totalEpisodes,
  });

  /// Watch progress from 0.0 to 1.0.
  double get progress {
    if (totalEpisodes <= 0) return 0.0;

    return (watchedEpisodes / totalEpisodes).clamp(0.0, 1.0).toDouble();
  }
}
