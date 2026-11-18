import 'package:flutter/material.dart';

/// "Genre" heading followed by a two column grid of colored genre names.
class DrawerGenreSection extends StatelessWidget {
  const DrawerGenreSection({
    super.key,
    required this.genres,
    required this.onSelected,
  });

  final List<String> genres;
  final ValueChanged<String> onSelected;

  static const List<Color> _genreColors = [
    Color(0xFF9ACD83), // Green
    Color(0xFFFFC76B), // Yellow
    Color(0xFFE58C83), // Coral
    Color(0xFFC49BD9), // Purple
    Color(0xFF82C6D6), // Cyan
    Color(0xFFD6A1BE), // Pink
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(14, 8, 14, 12),
          child: Text(
            'Genre',
            style: theme.textTheme.titleMedium?.copyWith(fontSize: 13),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: genres.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 2,
              crossAxisSpacing: 4,
              childAspectRatio: 3.6,
            ),
            itemBuilder: (context, index) {
              return _GenreItem(
                genre: genres[index],
                color: _genreColors[index % _genreColors.length],
                onTap: () => onSelected(genres[index]),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _GenreItem extends StatelessWidget {
  const _GenreItem({
    required this.genre,
    required this.color,
    required this.onTap,
  });

  final String genre;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(5),
      child: Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Text(
          genre,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: color,
            fontSize: 10,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
