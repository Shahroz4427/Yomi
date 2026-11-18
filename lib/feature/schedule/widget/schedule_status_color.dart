import 'package:flutter/material.dart';
import 'package:yomi/core/theme/app_theme.dart';
import 'package:yomi/data/models/schedule_entry.dart';

/// Accent color of each [ScheduleStatus].
extension ScheduleStatusColor on ScheduleStatus {
  Color get color {
    return switch (this) {
      ScheduleStatus.released => Colors.greenAccent.shade400,
      ScheduleStatus.releasing => AppTheme.secondaryColor,
      ScheduleStatus.upcoming => Colors.orangeAccent.shade200,
    };
  }
}
