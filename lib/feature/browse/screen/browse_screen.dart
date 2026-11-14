import 'package:flutter/material.dart';
import 'package:yomi/data/browse_category_data.dart';
import 'package:yomi/feature/browse/filters/filter_options.dart';
import 'package:yomi/feature/browse/widget/anime_grid.dart';
import 'package:yomi/feature/browse/widget/anime_search_field.dart';
import 'package:yomi/feature/browse/widget/browse_header.dart';
import 'package:yomi/feature/browse/widget/category_selector.dart';
import 'package:yomi/feature/browse/widget/filter_bottom_sheet.dart';
import 'package:yomi/feature/browse/widget/filter_button.dart';

class BrowseAnimeScreen extends StatefulWidget {
  const BrowseAnimeScreen({super.key});

  @override
  State<BrowseAnimeScreen> createState() => _BrowseAnimeScreenState();
}

class _BrowseAnimeScreenState extends State<BrowseAnimeScreen> {
  final TextEditingController _searchController = TextEditingController();

  String _selectedCategory = BrowseCategoryData.categories.first;

  // Filters that were confirmed with "Apply".
  FilterSelection _selectedFilters = {};

  Future<void> _openFilters() async {
    final result = await showFilterBottomSheet(
      context: context,
      initialFilters: _selectedFilters,
    );

    // null means the sheet was dismissed without applying.
    if (result != null && mounted) {
      setState(() => _selectedFilters = result);
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final animeList = BrowseCategoryData.animeForCategory(_selectedCategory);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              BrowseHeader(titleCount: animeList.length),
              const SizedBox(height: 18),
              AnimeSearchField(controller: _searchController),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: CategorySelector(
                      categories: BrowseCategoryData.categories,
                      selected: _selectedCategory,
                      onSelected: (category) {
                        setState(() => _selectedCategory = category);
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  FilterButton(
                    activeCount: countFilters(_selectedFilters),
                    onTap: _openFilters,
                  ),
                ],
              ),
              const SizedBox(height: 17),
              Expanded(child: AnimeGrid(animes: animeList)),
            ],
          ),
        ),
      ),
    );
  }
}
