import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemSelected;

  const BottomBar({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  final List<Map<String, dynamic>> _items = const [
    {
      'icon': Icons.home_outlined,
      'activeIcon': Icons.home,
      'label': 'Home',
    },
    {
      'icon': Icons.grid_view_rounded,
      'activeIcon': Icons.grid_view_rounded,
      'label': 'Browse',
    },
    {
      'icon': Icons.touch_app_sharp,
      'activeIcon': Icons.touch_app_sharp,
      'label': 'Top',
    },
    {
      'icon': Icons.access_time_rounded,
      'activeIcon': Icons.access_time_rounded,
      'label': 'Schedule',
    },
    {
      'icon': Icons.featured_play_list_rounded,
      'activeIcon': Icons.featured_play_list_rounded,
      'label': 'My List',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;

    return Container(
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        border: Border(
          top: BorderSide(
            color: theme.dividerColor.withValues(alpha: 0.5),
          ),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: List.generate(_items.length, (index) {
            final item = _items[index];
            final isSelected = selectedIndex == index;

            return Expanded(
              child: InkWell(
                borderRadius: BorderRadius.circular(16),
                splashColor: primary.withValues(alpha: 0.18),
                highlightColor: primary.withValues(alpha: 0.08),
                onTap: () => onItemSelected(index),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 180),
                        curve: Curves.easeOut,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 17,
                          vertical: 6,
                        ),
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
                            isSelected
                                ? item['activeIcon']
                                : item['icon'],
                            size: 23,
                            color: isSelected
                                ? primary
                                : Colors.white70,
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 180),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: isSelected
                              ? FontWeight.w600
                              : FontWeight.normal,
                        ),
                        child: Text(
                          item['label'],
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
