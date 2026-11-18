import 'package:yomi/data/models/schedule_entry.dart';

/// Where the UI gets the airing schedule from.
abstract interface class ScheduleRepository {
  /// All scheduled episodes of a week, for every weekday.
  List<ScheduleEntry> getWeeklySchedule();
}
