import 'package:flutter/material.dart';
import 'package:yomi/feature/browse/filters/filter_options.dart';
import 'package:yomi/feature/browse/widget/filter_action_bar.dart';
import 'package:yomi/feature/browse/widget/filter_selected.dart';
import 'package:yomi/feature/browse/widget/filter_sheet_header.dart';
import 'package:yomi/feature/browse/widget/selected_filter_row.dart';

/// Opens the filter sheet.
///
/// Returns the new selection when the user taps Apply, or null when the sheet
/// is dismissed without applying.
Future<FilterSelection?> showFilterBottomSheet({
  required BuildContext context,
  required FilterSelection initialFilters,
}) {
  return showModalBottomSheet<FilterSelection>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: Colors.transparent,
    barrierColor: Colors.black.withValues(alpha: 0.65),
    builder: (_) => FilterBottomSheet(initialFilters: initialFilters),
  );
}

/// The sheet itself. Edits a draft copy of the filters; nothing changes on the
/// page until Apply is pressed.
class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({super.key, required this.initialFilters});

  final FilterSelection initialFilters;

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  late final FilterSelection _draft = copyFilters(widget.initialFilters);

  void _toggle(String group, String option) {
    setState(() {
      final values = _draft.putIfAbsent(group, () => <String>{});

      if (values.contains(option)) {
        values.remove(option);
      } else {
        if (!kMultiSelectGroups.contains(group)) values.clear();
        values.add(option);
      }

      if (values.isEmpty) _draft.remove(group);
    });
  }

  void _reset() => setState(_draft.clear);

  void _apply() => Navigator.pop(context, copyFilters(_draft));

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final selectedCount = countFilters(_draft);

    return DraggableScrollableSheet(
      initialChildSize: 0.82,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      expand: false,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: colors.surface,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
            border: Border(
              top: BorderSide(
                color: colors.outlineVariant.withValues(alpha: 0.6),
              ),
            ),
          ),
          child: Column(
            children: [
              const _SheetHandle(),
              FilterSheetHeader(
                selectedCount: selectedCount,
                onClose: () => Navigator.pop(context),
              ),
              SelectedFiltersRow(filters: _draft, onRemove: _toggle),
              Divider(height: 1, color: theme.dividerColor),
              Expanded(
                child: ListView(
                  controller: scrollController,
                  padding: const EdgeInsets.fromLTRB(20, 18, 20, 12),
                  children: [
                    for (final entry in kFilterOptions.entries)
                      FilterSection(
                        title: entry.key,
                        options: entry.value,
                        selected: _draft[entry.key] ?? const <String>{},
                        isMulti: kMultiSelectGroups.contains(entry.key),
                        onToggle: (option) => _toggle(entry.key, option),
                      ),
                  ],
                ),
              ),
              FilterActionBar(
                selectedCount: selectedCount,
                onReset: _reset,
                onApply: _apply,
              ),
            ],
          ),
        );
      },
    );
  }
}

class _SheetHandle extends StatelessWidget {
  const _SheetHandle();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
        width: 40,
        height: 4,
        decoration: BoxDecoration(
          color: colors.onSurfaceVariant.withValues(alpha: 0.4),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
