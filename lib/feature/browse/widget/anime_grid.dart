import 'package:flutter/material.dart';
import 'package:yomi/data/models/anime_item.dart';
import 'package:yomi/shared/widgets/anime_card.dart';

/// Grid of anime cards, or an empty message when there is nothing to show.
class AnimeGrid extends StatelessWidget {
  const AnimeGrid({super.key, required this.animes});

  final List<AnimeItem> animes;

  @override
  Widget build(BuildContext context) {
    if (animes.isEmpty) {
      return Center(
        child: Text(
          'No anime available',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      );
    }

    return GridView.builder(
      itemCount: animes.length,
      padding: const EdgeInsets.only(bottom: 16),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 190,
        crossAxisSpacing: 12,
        mainAxisSpacing: 16,
        childAspectRatio: 0.62,
      ),
      itemBuilder: (context, index) => AnimeCard(anime: animes[index]),
    );
  }
}
