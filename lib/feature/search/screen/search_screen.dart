import 'package:flutter/material.dart';
import 'package:yomi/data/repositories/anime_repository.dart';
import 'package:yomi/feature/search/widget/search_results.dart';
import 'package:yomi/feature/search/widget/trending_searches.dart';

/// Search page: trending searches until the user types, then matching anime.
class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key, required this.repository});

  final AnimeRepository repository;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();

  String _query = '';

  void _setQuery(String value) {
    setState(() => _query = value.trim());
  }

  // Used by the trending chips: fill the field and search right away.
  void _searchFor(String term) {
    _controller.value = TextEditingValue(
      text: term,
      selection: TextSelection.collapsed(offset: term.length),
    );
    _setQuery(term);
  }

  void _clear() {
    _controller.clear();
    _setQuery('');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: TextField(
          controller: _controller,
          autofocus: true,
          cursorColor: colors.primary,
          style: theme.textTheme.bodyLarge,
          textInputAction: TextInputAction.search,
          onChanged: _setQuery,
          decoration: InputDecoration(
            hintText: 'Search anime...',
            hintStyle: theme.textTheme.bodyMedium,
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            filled: false,
            contentPadding: EdgeInsets.zero,
          ),
        ),
        actions: [
          if (_query.isNotEmpty)
            IconButton(
              onPressed: _clear,
              icon: const Icon(Icons.close_rounded),
              tooltip: 'Clear',
            ),
        ],
      ),
      body: _query.isEmpty
          ? TrendingSearches(onSelected: _searchFor)
          : SearchResults(query: _query, repository: widget.repository),
    );
  }
}
