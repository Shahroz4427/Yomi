import 'package:flutter/material.dart';
import 'package:yomi/core/theme/app_theme.dart';

/// Bold heading used above each block of the schedule screen.
class SectionTitle extends StatelessWidget {
  const SectionTitle(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: AppTheme.primaryTextColor,
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
