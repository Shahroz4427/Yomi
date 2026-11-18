import 'package:yomi/data/models/schedule_entry.dart';
import 'package:yomi/data/repositories/schedule_repository.dart';
import 'package:yomi/data/sources/static_anime_data.dart';

/// [ScheduleRepository] backed by dummy data (UI development phase).
class StaticScheduleRepository implements ScheduleRepository {
  const StaticScheduleRepository();

  @override
  List<ScheduleEntry> getWeeklySchedule() {
    final animes = StaticAnimeData.allTimePopularAnimes;

    ScheduleEntry entry({
      required int weekday,
      required int animeIndex,
      required int episode,
      required String time,
      required String genre,
      required ScheduleStatus status,
    }) {
      return ScheduleEntry(
        anime: animes[animeIndex % animes.length],
        weekday: weekday,
        episode: episode,
        time: time,
        genre: genre,
        status: status,
      );
    }

    return [
      entry(
        weekday: 1,
        animeIndex: 0,
        episode: 1152,
        time: '10:00 AM',
        genre: 'Adventure',
        status: ScheduleStatus.released,
      ),
      entry(
        weekday: 1,
        animeIndex: 1,
        episode: 8,
        time: '06:30 PM',
        genre: 'Action',
        status: ScheduleStatus.upcoming,
      ),
      entry(
        weekday: 1,
        animeIndex: 2,
        episode: 12,
        time: '09:00 PM',
        genre: 'Action',
        status: ScheduleStatus.upcoming,
      ),
      entry(
        weekday: 1,
        animeIndex: 3,
        episode: 5,
        time: '09:30 PM',
        genre: 'Mystery',
        status: ScheduleStatus.releasing,
      ),
      entry(
        weekday: 2,
        animeIndex: 4,
        episode: 7,
        time: '05:00 PM',
        genre: 'Action',
        status: ScheduleStatus.upcoming,
      ),
      entry(
        weekday: 2,
        animeIndex: 5,
        episode: 15,
        time: '08:00 PM',
        genre: 'Adventure',
        status: ScheduleStatus.upcoming,
      ),
      entry(
        weekday: 3,
        animeIndex: 0,
        episode: 1153,
        time: '10:00 AM',
        genre: 'Adventure',
        status: ScheduleStatus.upcoming,
      ),
      entry(
        weekday: 3,
        animeIndex: 2,
        episode: 13,
        time: '09:00 PM',
        genre: 'Action',
        status: ScheduleStatus.upcoming,
      ),
      entry(
        weekday: 4,
        animeIndex: 1,
        episode: 9,
        time: '06:30 PM',
        genre: 'Action',
        status: ScheduleStatus.upcoming,
      ),
      entry(
        weekday: 5,
        animeIndex: 3,
        episode: 6,
        time: '09:30 PM',
        genre: 'Mystery',
        status: ScheduleStatus.upcoming,
      ),
      entry(
        weekday: 6,
        animeIndex: 4,
        episode: 8,
        time: '05:00 PM',
        genre: 'Action',
        status: ScheduleStatus.upcoming,
      ),
      entry(
        weekday: 7,
        animeIndex: 5,
        episode: 16,
        time: '08:00 PM',
        genre: 'Adventure',
        status: ScheduleStatus.upcoming,
      ),
    ];
  }
}
