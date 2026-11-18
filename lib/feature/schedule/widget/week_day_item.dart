import 'package:flutter/material.dart';
import 'package:yomi/core/theme/app_theme.dart';
import 'package:yomi/core/utils/date_labels.dart';

/// One day chip of the week selector: weekday, day number and a dot when
/// the day has scheduled episodes.
class WeekDayItem extends StatelessWidget {
  const WeekDayItem({
    super.key,
    required this.date,
    required this.isSelected,
    required this.isToday,
    required this.hasSchedule,
    required this.onTap,
  });

  final DateTime date;
  final bool isSelected;
  final bool isToday;
  final bool hasSchedule;
  final VoidCallback onTap;

  Color get _borderColor {
    if (isSelected) return AppTheme.secondaryColor;
    if (isToday) return AppTheme.primaryColor.withValues(alpha: 0.6);

    return AppTheme.borderColor;
  }

  Color get _dotColor {
    if (!hasSchedule) return Colors.transparent;

    return isSelected ? Colors.white : AppTheme.secondaryColor;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: InkWell(
        borderRadius: BorderRadius.circular(13),
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 11),
          decoration: BoxDecoration(
            color: isSelected ? AppTheme.primaryColor : AppTheme.surfaceColor,
            borderRadius: BorderRadius.circular(13),
            border: Border.all(color: _borderColor),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: AppTheme.primaryColor.withValues(alpha: 0.2),
                      blurRadius: 10,
                    ),
                  ]
                : [],
          ),
          child: Column(
            children: [
              Text(
                DateLabels.weekdayShort(date.weekday),
                style: TextStyle(
                  color: isSelected
                      ? Colors.white
                      : AppTheme.secondaryTextColor,
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 9),
              Text(
                date.day.toString(),
                style: TextStyle(
                  color: isSelected ? Colors.white : AppTheme.primaryTextColor,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: 5,
                height: 5,
                decoration: BoxDecoration(
                  color: _dotColor,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
