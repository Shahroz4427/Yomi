import 'package:flutter/material.dart';
import 'package:yomi/core/theme/app_theme.dart';

/// Bottom sheet with a search field. [onChanged] is called on every key.
Future<void> showMyListSearchSheet({
  required BuildContext context,
  required ValueChanged<String> onChanged,
}) {
  return showModalBottomSheet<void>(
    context: context,
    backgroundColor: AppTheme.surfaceColor,
    isScrollControlled: true,
    builder: (context) {
      return Padding(
        padding: EdgeInsets.fromLTRB(
          16,
          20,
          16,
          MediaQuery.of(context).viewInsets.bottom + 20,
        ),
        child: TextField(
          autofocus: true,
          style: const TextStyle(color: AppTheme.primaryTextColor),
          decoration: InputDecoration(
            hintText: 'Search your list...',
            hintStyle: const TextStyle(color: AppTheme.secondaryTextColor),
            prefixIcon: const Icon(Icons.search),
            filled: true,
            fillColor: AppTheme.backgroundColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
          onChanged: onChanged,
        ),
      );
    },
  );
}
