import 'package:flutter/material.dart';

/// Search box with a clear button.
class AnimeSearchField extends StatelessWidget {
  const AnimeSearchField({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return TextField(
      controller: controller,
      style: theme.textTheme.bodyMedium,
      decoration: InputDecoration(
        hintText: 'Search anime...',
        prefixIcon: Icon(Icons.search_rounded, color: colors.onSurfaceVariant),
        suffixIcon: IconButton(
          onPressed: controller.clear,
          icon: Icon(
            Icons.close_rounded,
            color: colors.onSurfaceVariant,
            size: 19,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 13),
      ),
    );
  }
}