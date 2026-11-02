import 'dart:ui';

import 'package:flutter/material.dart';

class SideDrawer extends StatelessWidget {
  final ValueChanged<String>? onItemSelected;
  final VoidCallback? onCommunityTap;

  const SideDrawer({super.key, this.onItemSelected, this.onCommunityTap});

  static const List<String> menuItems = [
    'Home',
    'Subbed Anime',
    'Dubbed Anime',
    'Most Popular',
    'Movies',
    'TV Series',
    'OVAs',
    'ONAs',
    'Specials',
    'Events',
  ];

  static const List<String> genres = [
    'Action',
    'Action & Adventure',
    'Adult Cast',
    'Adventure',
    'Animation',
    'Boys Love',
    'Cars',
    'Comedy',
    'Dementia',
    'Demons',
    'Drama',
    'Fantasy',
    'Game',
    'Harem',
    'Historical',
    'Horror',
    'Isekai',
    'Josei',
    'Magic',
    'Martial Arts',
    'Mecha',
    'Military',
    'Music',
    'Mystery',
    'Parody',
    'Psychological',
    'Romance',
    'Samurai',
    'School',
    'Sci-Fi',
    'Seinen',
    'Shoujo',
    'Shounen',
    'Slice of Life',
    'Sports',
    'Supernatural',
    'Thriller',
    'Vampire',
  ];

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
                  // Header
                  _buildHeader(context),

                  // Quick actions
                  _buildQuickActions(context),

                  // Community
                  _buildCommunityButton(context),

                  const SizedBox(height: 12),

                  // Navigation items
                  ...menuItems.map((item) => _buildMenuItem(context, item)),

                  const SizedBox(height: 12),

                  // Genre heading
                  Padding(
                    padding: const EdgeInsets.fromLTRB(14, 8, 14, 12),
                    child: Text(
                      'Genre',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontSize: 13,
                      ),
                    ),
                  ),

                  // Genre grid
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: genres.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 2,
                            crossAxisSpacing: 4,
                            childAspectRatio: 3.6,
                          ),
                      itemBuilder: (context, index) {
                        return _buildGenreItem(context, genres[index], index);
                      },
                    ),
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

  // Header
  Widget _buildHeader(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      height: 65,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: theme.dividerColor)),
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: InkWell(
          onTap: () => Navigator.pop(context),
          borderRadius: BorderRadius.circular(6),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.chevron_left,
                  color: theme.colorScheme.onSurface,
                  size: 20,
                ),
                const SizedBox(width: 3),
                Text(
                  'Close menu',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurface,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Quick actions
  Widget _buildQuickActions(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: theme.dividerColor)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _quickAction(context, Icons.wifi_tethering, 'W2G'),
          _quickAction(context, Icons.shuffle_rounded, 'Random'),
          _quickAction(context, Icons.language, 'Name'),
          _quickAction(context, Icons.rss_feed_rounded, 'News'),
        ],
      ),
    );
  }

  Widget _quickAction(BuildContext context, IconData icon, String label) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return InkWell(
      onTap: () => _selectItem(context, label),
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

  // Community button
  Widget _buildCommunityButton(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 14, 10, 8),
      child: Material(
        color: colors.primary.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(30),
        child: InkWell(
          onTap: () {
            Navigator.pop(context);
            onCommunityTap?.call();
          },
          borderRadius: BorderRadius.circular(30),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.forum_rounded, color: colors.secondary, size: 15),
                const SizedBox(width: 6),
                Text(
                  'Community',
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: colors.onSurface,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Navigation item
  Widget _buildMenuItem(BuildContext context, String title) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return InkWell(
      onTap: () => _selectItem(context, title),
      child: Container(
        height: 44,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: theme.dividerColor.withValues(alpha: 0.5),
              width: 0.5,
            ),
          ),
        ),
        child: Text(
          title,
          style: theme.textTheme.bodySmall?.copyWith(
            color: colors.onSurface,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  // Genre item
  Widget _buildGenreItem(BuildContext context, String genre, int index) {
    const genreColors = [
      Color(0xFF9ACD83), // Green
      Color(0xFFFFC76B), // Yellow
      Color(0xFFE58C83), // Coral
      Color(0xFFC49BD9), // Purple
      Color(0xFF82C6D6), // Cyan
      Color(0xFFD6A1BE), // Pink
    ];

    return InkWell(
      onTap: () => _selectItem(context, genre),
      borderRadius: BorderRadius.circular(5),
      child: Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Text(
          genre,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: genreColors[index % genreColors.length],
            fontSize: 10,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
