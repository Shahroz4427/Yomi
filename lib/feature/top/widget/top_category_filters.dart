import 'package:flutter/material.dart';
import 'package:yomi/data/models/top_category.dart';
import 'package:yomi/feature/top/widget/top_category_chip.dart';

/// Wrapping row of category chips for the Top screen.
class TopCategoryFilters extends StatelessWidget {
  const TopCategoryFilters({
    super.key,
    required this.selected,
    required this.onSelected,
  });

  final TopCategory selected;
  final ValueChanged<TopCategory> onSelected;

  @override
  Widget build(BuildContext context) {
    // The parent Column centers its children. Without a full-width box the
    // Wrap shrinks to its chips and gets centered when they all fit on one
    // line (wide screens). The infinite width keeps it left-aligned.
    return SizedBox(
        width: double.infinity,
        child: Padding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 15),
            child: Wrap(
              alignment: WrapAlignment.start,
              spacing: 9,
              runSpacing: 9,
              children: [
                for (final category in TopCategory.values)
                  TopCategoryChip(
                    category: category,
                    isSelected: category == selected,
                    onTap: () => onSelected(category),
                  ),
              ],
            ),
        )
    );
  }
}
