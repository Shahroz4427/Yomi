import 'package:flutter/material.dart';

/// Row of four quick action shortcuts (W2G, Random, Name, News).
class DrawerQuickActions extends StatelessWidget {
  const DrawerQuickActions({super.key, required this.onSelected});

  /// Called with the label of the tapped action.
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: theme.dividerColor)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _QuickAction(
            icon: Icons.wifi_tethering,
            label: 'W2G',
            onTap: () => onSelected('W2G'),
          ),
          _QuickAction(
            icon: Icons.shuffle_rounded,
            label: 'Random',
            onTap: () => onSelected('Random'),
          ),
          _QuickAction(
            icon: Icons.language,
            label: 'Name',
            onTap: () => onSelected('Name'),
          ),
          _QuickAction(
            icon: Icons.rss_feed_rounded,
            label: 'News',
            onTap: () => onSelected('News'),
          ),
        ],
      ),
    );
  }
}

class _QuickAction extends StatelessWidget {
  const _QuickAction({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: SizedBox(
        width: 56,
        child: Column(
          children: [
            Icon(icon, size: 20, color: colors.secondary),
            const SizedBox(height: 5),
            Text(
              label,
              style: theme.textTheme.labelSmall?.copyWith(
                color: colors.onSurface,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
