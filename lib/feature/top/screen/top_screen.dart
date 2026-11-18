import 'package:flutter/material.dart';
import 'package:yomi/data/models/top_category.dart';
import 'package:yomi/data/repositories/anime_repository.dart';
import 'package:yomi/feature/details/anime_details_navigation.dart';
import 'package:yomi/feature/top/widget/top_anime_list.dart';
import 'package:yomi/feature/top/widget/top_category_filters.dart';
import 'package:yomi/feature/top/widget/top_header.dart';

/// Top tab: ranking of anime for the selected category.
class TopScreen extends StatefulWidget {
  const TopScreen({super.key, required this.repository});

  final AnimeRepository repository;

  @override
  State<TopScreen> createState() => _TopScreenState();
}

class _TopScreenState extends State<TopScreen> {
  TopCategory _selectedCategory = TopCategory.mostPopular;

  @override
  Widget build(BuildContext context) {
    final animes = widget.repository.getTopAnime(_selectedCategory);

    return SafeArea(
      child: Column(
        children: [
          const TopHeader(),
          TopCategoryFilters(
            selected: _selectedCategory,
            onSelected: (category) {
              setState(() => _selectedCategory = category);
            },
          ),
          const SizedBox(height: 18),
          Expanded(
            child: TopAnimeList(
              animes: animes,
              onAnimeTap: (anime) {
                openAnimeDetails(
                  context,
                  anime: anime,
                  repository: widget.repository,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
