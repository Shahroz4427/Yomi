/// Human readable labels for weekdays, months and week ranges.
abstract final class DateLabels {
  static const List<String> _weekdays = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];

  static const List<String> _weekdaysShort = [
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun',
  ];

  static const List<String> _monthsShort = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];

  /// "Monday" for [DateTime.monday] (1) ... "Sunday" for 7.
  static String weekday(int weekday) => _weekdays[weekday - 1];

  /// "Mon" for [DateTime.monday] (1) ... "Sun" for 7.
  static String weekdayShort(int weekday) => _weekdaysShort[weekday - 1];

  /// "Jan" for 1 ... "Dec" for 12.
  static String monthShort(int month) => _monthsShort[month - 1];

  /// "Nov 10 - 16, 2026" or, across two months, "Oct 27 - Nov 2".
  static String weekRange(DateTime start, DateTime end) {
    if (start.month == end.month) {
      return '${monthShort(start.month)} ${start.day} - ${end.day}, ${end.year}';
    }

    return '${monthShort(start.month)} ${start.day} - '
        '${monthShort(end.month)} ${end.day}';
  }
}
