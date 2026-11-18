import 'package:flutter/material.dart';
import 'package:yomi/core/utils/date_labels.dart';
import 'package:yomi/data/models/schedule_entry.dart';
import 'package:yomi/data/repositories/anime_repository.dart';
import 'package:yomi/data/repositories/schedule_repository.dart';
import 'package:yomi/feature/details/anime_details_navigation.dart';
import 'package:yomi/feature/schedule/widget/daily_overview.dart';
import 'package:yomi/feature/schedule/widget/schedule_header.dart';
import 'package:yomi/feature/schedule/widget/schedule_list.dart';
import 'package:yomi/feature/schedule/widget/schedule_status_filter.dart';
import 'package:yomi/feature/schedule/widget/week_selector.dart';

/// Schedule tab: week picker, daily overview and the episodes of the day.
class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({
    super.key,
    required this.repository,
    required this.animeRepository,
  });

  final ScheduleRepository repository;

  /// Used to open the details screen of a scheduled anime.
  final AnimeRepository animeRepository;

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  late final List<ScheduleEntry> _entries = widget.repository
      .getWeeklySchedule();

  DateTime _selectedDate = DateUtils.dateOnly(DateTime.now());

  // null means "All".
  ScheduleStatus? _selectedStatus;

  // Monday of the week that contains the selected date.
  DateTime get _weekStart {
    return DateUtils.dateOnly(
      _selectedDate.subtract(Duration(days: _selectedDate.weekday - 1)),
    );
  }

  List<DateTime> get _weekDates {
    return List.generate(7, (index) => _weekStart.add(Duration(days: index)));
  }

  List<ScheduleEntry> get _selectedDayEntries {
    return _entries
        .where((entry) => entry.weekday == _selectedDate.weekday)
        .toList();
  }

  int _countOf(List<ScheduleEntry> entries, ScheduleStatus status) {
    return entries.where((entry) => entry.status == status).length;
  }

  void _selectDate(DateTime date) {
    setState(() {
      _selectedDate = date;
      _selectedStatus = null;
    });
  }

  void _goToToday() => _selectDate(DateUtils.dateOnly(DateTime.now()));

  void _shiftWeek(int days) {
    _selectDate(_selectedDate.add(Duration(days: days)));
  }

  @override
  Widget build(BuildContext context) {
    final dayEntries = _selectedDayEntries;

    final visibleEntries = _selectedStatus == null
        ? dayEntries
        : dayEntries.where((entry) => entry.status == _selectedStatus).toList();

    return SafeArea(
      child: Column(
        children: [
          ScheduleHeader(onTodayTap: _goToToday),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.only(bottom: 20),
              children: [
                WeekSelector(
                  weekDates: _weekDates,
                  selectedDate: _selectedDate,
                  scheduledWeekdays: {
                    for (final entry in _entries) entry.weekday,
                  },
                  onDateSelected: _selectDate,
                  onPreviousWeek: () => _shiftWeek(-7),
                  onNextWeek: () => _shiftWeek(7),
                ),
                const SizedBox(height: 20),
                DailyOverview(
                  total: dayEntries.length,
                  released: _countOf(dayEntries, ScheduleStatus.released),
                  upcoming: _countOf(dayEntries, ScheduleStatus.upcoming),
                ),
                const SizedBox(height: 24),
                ScheduleStatusFilter(
                  selected: _selectedStatus,
                  onSelected: (status) {
                    setState(() => _selectedStatus = status);
                  },
                ),
                const SizedBox(height: 18),
                ScheduleList(
                  dayName: DateLabels.weekday(_selectedDate.weekday),
                  entries: visibleEntries,
                  onEntryTap: (entry) {
                    openAnimeDetails(
                      context,
                      anime: entry.anime,
                      repository: widget.animeRepository,
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
