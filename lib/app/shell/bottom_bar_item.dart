import 'package:flutter/material.dart';

/// Icons and label of one bottom navigation tab.
class BottomBarDestination {
  final IconData icon;
  final IconData activeIcon;
  final String label;

  const BottomBarDestination({
    required this.icon,
    required this.activeIcon,
    required this.label,
  });
}

/// One tab of the bottom navigation: animated icon pill and label.
class BottomBarItem extends StatelessWidget {
  const BottomBarItem({
    super.key,
    required this.destination,
    required this.isSelected,
    required this.onTap,
  });

  final BottomBarDestination destination;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;

    return InkWell(
      borderRadius: BorderRadius.circular(16),
      splashColor: primary.withValues(alpha: 0.18),
      highlightColor: primary.withValues(alpha: 0.08),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              curve: Curves.easeOut,
              padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 6),
              decoration: BoxDecoration(
                color: isSelected
                    ? primary.withValues(alpha: 0.18)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(14),
              ),
              child: AnimatedScale(
                scale: isSelected ? 1.08 : 1.0,
                duration: const Duration(milliseconds: 180),
                child: Icon(
                  isSelected ? destination.activeIcon : destination.icon,
                  size: 23,
                  color: isSelected ? primary : Colors.white70,
                ),
              ),
            ),
            const SizedBox(height: 4),
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 180),
              style: TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
              child: Text(destination.label, maxLines: 1),
            ),
          ],
        ),
      ),
    );
  }
}
