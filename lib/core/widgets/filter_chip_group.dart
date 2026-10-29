import 'package:flutter/material.dart';

class FilterChipGroup<T> extends StatelessWidget {
  const FilterChipGroup({
    super.key,
    required this.items,
    required this.selected,
    required this.labelBuilder,
    required this.onSelected,
  });

  final List<T> items;
  final T selected;
  final String Function(T value) labelBuilder;
  final ValueChanged<T> onSelected;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: items
          .map(
            (item) => ChoiceChip(
              label: Text(labelBuilder(item)),
              selected: item == selected,
              onSelected: (_) => onSelected(item),
            ),
          )
          .toList(),
    );
  }
}
