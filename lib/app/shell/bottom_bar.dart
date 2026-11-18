import 'package:flutter/material.dart';
import 'package:yomi/app/shell/bottom_bar_item.dart';

/// Bottom navigation with the five main tabs.
class BottomBar extends StatelessWidget {
  const BottomBar({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  final int selectedIndex;
  final ValueChanged<int> onItemSelected;

  // Order must match the screens in MainScreen.
  static const List<BottomBarDestination> _destinations = [
    BottomBarDestination(
      icon: Icons.home_outlined,
      activeIcon: Icons.home,
      label: 'Home',
    ),
    BottomBarDestination(
      icon: Icons.grid_view_rounded,
      activeIcon: Icons.grid_view_rounded,
      label: 'Browse',
    ),
    BottomBarDestination(
      icon: Icons.touch_app_sharp,
      activeIcon: Icons.touch_app_sharp,
      label: 'Top',
    ),
    BottomBarDestination(
      icon: Icons.access_time_rounded,
      activeIcon: Icons.access_time_rounded,
      label: 'Schedule',
    ),
    BottomBarDestination(
      icon: Icons.featured_play_list_rounded,
      activeIcon: Icons.featured_play_list_rounded,
      label: 'My List',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        border: Border(
          top: BorderSide(color: theme.dividerColor.withValues(alpha: 0.5)),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            for (var index = 0; index < _destinations.length; index++)
              Expanded(
                child: BottomBarItem(
                  destination: _destinations[index],
                  isSelected: selectedIndex == index,
                  onTap: () => onItemSelected(index),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
