import 'package:flutter/material.dart';
import 'package:yomi/core/theme/app_theme.dart';

/// Bottom sheet with actions for one saved anime.
///
/// TODO: pass the selected entry and implement "Change status" and
/// "Remove from list".
Future<void> showMyListOptionsSheet({required BuildContext context}) {
  return showModalBottomSheet<void>(
    context: context,
    backgroundColor: AppTheme.surfaceColor,
    builder: (context) {
      return SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.edit_outlined),
              title: const Text('Change status'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.remove_circle_outline),
              title: const Text('Remove from list'),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      );
    },
  );
}
