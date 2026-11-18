import 'package:yomi/data/models/anime_item.dart';

/// Release state of a scheduled episode.
///
/// The declaration order is the order used by the schedule filter chips.
enum ScheduleStatus {
  releasing('Releasing'),
  released('Released'),
  upcoming('Upcoming');

  const ScheduleStatus(this.label);

  /// Text shown in the UI.
  final String label;
}

/// One episode in the weekly airing schedule.
class ScheduleEntry {
  final AnimeItem anime;

  /// Monday = 1 ... Sunday = 7 (same as [DateTime.weekday]).
  final int weekday;
  final int episode;
  final String time;
  final String genre;
  final ScheduleStatus status;

  const ScheduleEntry({
    required this.anime,
    required this.weekday,
    required this.episode,
    required this.time,
    required this.genre,
    required this.status,
  });
}
