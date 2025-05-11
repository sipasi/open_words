import 'package:flutter/material.dart';
import 'package:open_words/shared/layout/adaptive_grid_view.dart';
import 'package:open_words/shared/theme/theme_extension.dart';

class SelectableGridView<T> extends StatelessWidget {
  final List<T> items;
  final Set<T> selected;

  final String Function(T item) title;

  final void Function(T item) onToggle;

  const SelectableGridView({
    super.key,
    required this.items,
    required this.selected,
    required this.title,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return AdaptiveGridView(
      itemCount: items.length,
      maxCrossAxisExtent: 300,
      itemBuilder: (context, index) {
        final item = items[index];
        final isSelected = selected.contains(item);

        return Card.outlined(
          color: isSelected ? context.colorScheme.secondaryContainer : null,
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: () => onToggle(item),
            splashColor: context.colorScheme.primary.withAlpha(80),
            hoverColor: context.colorScheme.primary.withAlpha(40),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 10,
              ),
              child: Text(
                title(item),
                style: TextStyle(
                  color: context.colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
