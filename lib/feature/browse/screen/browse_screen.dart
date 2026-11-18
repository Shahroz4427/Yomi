import 'package:flutter/material.dart';
import 'package:yomi/data/models/browse_category.dart';
import 'package:yomi/data/repositories/anime_repository.dart';
import 'package:yomi/feature/browse/filters/filter_bottom_sheet.dart';
import 'package:yomi/feature/browse/filters/filter_options.dart';
import 'package:yomi/feature/browse/widget/anime_grid.dart';
import 'package:yomi/feature/browse/widget/anime_search_field.dart';
import 'package:yomi/feature/browse/widget/browse_header.dart';
import 'package:yomi/feature/browse/widget/category_selector.dart';
import 'package:yomi/feature/browse/widget/filter_button.dart';

/// Browse tab: search, category chips, filter button and anime grid.
///
/// Owns only the page state (selected category and applied filters) and
/// wires the smaller widgets together.
class BrowseScreen extends StatefulWidget {
  const BrowseScreen({super.key, required this.repository});

  final AnimeRepository repository;

  @override
  State<BrowseScreen> createState() => _BrowseScreenState();
}

class _BrowseScreenState extends State<BrowseScreen> {
  final TextEditingController _searchController = TextEditingController();

  BrowseCategory _selectedCategory = BrowseCategory.mostPopular;

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
    final animeList = widget.repository.getBrowseAnime(_selectedCategory);

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
                      categories: BrowseCategory.values,
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
