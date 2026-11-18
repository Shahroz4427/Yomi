import 'package:flutter/material.dart';
import 'package:yomi/core/theme/app_theme.dart';
import 'package:yomi/core/utils/date_labels.dart';
import 'package:yomi/feature/schedule/widget/week_day_item.dart';

/// Week range label, previous / next week buttons and the seven day chips.
class WeekSelector extends StatelessWidget {
  const WeekSelector({
    super.key,
    required this.weekDates,
    required this.selectedDate,
    required this.scheduledWeekdays,
    required this.onDateSelected,
    required this.onPreviousWeek,
    required this.onNextWeek,
  });

  /// The seven dates of the shown week, Monday first.
  final List<DateTime> weekDates;
  final DateTime selectedDate;

  /// Weekdays (Monday = 1) that have at least one scheduled episode.
  final Set<int> scheduledWeekdays;
  final ValueChanged<DateTime> onDateSelected;
  final VoidCallback onPreviousWeek;
  final VoidCallback onNextWeek;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    DateLabels.weekRange(weekDates.first, weekDates.last),
                    style: const TextStyle(
                      color: AppTheme.primaryTextColor,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Weekly airing schedule',
                    style: TextStyle(
                      color: AppTheme.secondaryTextColor,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  _WeekButton(
                    icon: Icons.chevron_left_rounded,
                    onTap: onPreviousWeek,
                  ),
                  const SizedBox(width: 7),
                  _WeekButton(
                    icon: Icons.chevron_right_rounded,
                    onTap: onNextWeek,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              for (final date in weekDates)
                Expanded(
                  child: WeekDayItem(
                    date: date,
                    isSelected: DateUtils.isSameDay(date, selectedDate),
                    isToday: DateUtils.isSameDay(date, DateTime.now()),
                    hasSchedule: scheduledWeekdays.contains(date.weekday),
                    onTap: () => onDateSelected(date),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _WeekButton extends StatelessWidget {
  const _WeekButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(9),
      onTap: onTap,
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: AppTheme.surfaceColor,
          borderRadius: BorderRadius.circular(9),
          border: Border.all(color: AppTheme.borderColor),
        ),
        child: Icon(icon, color: AppTheme.secondaryTextColor, size: 20),
      ),
    );
  }
}
