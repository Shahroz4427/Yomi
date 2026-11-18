import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:yomi/app/shell/side_drawer/drawer_community_button.dart';
import 'package:yomi/app/shell/side_drawer/drawer_content.dart';
import 'package:yomi/app/shell/side_drawer/drawer_genre_section.dart';
import 'package:yomi/app/shell/side_drawer/drawer_header_bar.dart';
import 'package:yomi/app/shell/side_drawer/drawer_menu_item.dart';
import 'package:yomi/app/shell/side_drawer/drawer_quick_actions.dart';

/// Blurred side menu opened from the top bar.
class SideDrawer extends StatelessWidget {
  const SideDrawer({super.key, this.onItemSelected, this.onCommunityTap});

  /// Called with the label of the tapped item after the drawer closes.
  final ValueChanged<String>? onItemSelected;
  final VoidCallback? onCommunityTap;

  void _selectItem(BuildContext context, String item) {
    Navigator.pop(context);
    onItemSelected?.call(item);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Drawer(
      width: 280,
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Container(
            decoration: BoxDecoration(
              color: colors.surface.withValues(alpha: 0.96),
              border: Border(
                right: BorderSide(color: theme.dividerColor, width: 0.7),
              ),
            ),
            child: SafeArea(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  DrawerHeaderBar(onClose: () => Navigator.pop(context)),
                  DrawerQuickActions(
                    onSelected: (label) => _selectItem(context, label),
                  ),
                  DrawerCommunityButton(
                    onTap: () {
                      Navigator.pop(context);
                      onCommunityTap?.call();
                    },
                  ),
                  const SizedBox(height: 12),
                  for (final item in kDrawerMenuItems)
                    DrawerMenuItem(
                      title: item,
                      onTap: () => _selectItem(context, item),
                    ),
                  const SizedBox(height: 12),
                  DrawerGenreSection(
                    genres: kDrawerGenres,
                    onSelected: (genre) => _selectItem(context, genre),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
