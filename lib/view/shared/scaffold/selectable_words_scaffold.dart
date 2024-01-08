import 'package:flutter/material.dart';
import 'package:open_words/data/word/word_group.dart';
import 'package:open_words/view/shared/list/adaptive_grid_view.dart';
import 'package:open_words/view/shared/tile/text_tile.dart';

class SelectableWordsScaffold extends StatelessWidget {
  final int count;
  final bool allSelected;

  final void Function() onSelectAll;

  final WordGroup Function(int index) groupAt;

  final bool Function(int index) selectedAt;

  final void Function(bool contains, int index) onTap;

  final Widget? fab;

  const SelectableWordsScaffold({
    super.key,
    required this.allSelected,
    required this.onSelectAll,
    required this.count,
    required this.groupAt,
    required this.selectedAt,
    required this.onTap,
    this.fab,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          allSelected
              ? IconButton(
                  onPressed: onSelectAll,
                  icon: const Icon(Icons.done),
                )
              : TextButton(
                  onPressed: onSelectAll,
                  child: const Text('select all'),
                )
        ],
      ),
      floatingActionButton: fab,
      body: AdaptiveGridView(
        children: List.generate(
          count,
          (index) => _tile(index),
        ),
      ),
    );
  }

  Widget _tile(int index) {
    final entity = groupAt(index);

    bool contains = selectedAt(index);

    return ListTile(
      onTap: () => onTap(contains, index),
      title: _title(entity),
      titleAlignment: ListTileTitleAlignment.top,
      selected: contains,
      trailing: Icon(Icons.circle, color: contains ? null : Colors.transparent),
    );
  }

  Widget _title(WordGroup group) {
    final name = group.name;
    final length = group.words.length.toString();

    return Text('$name [$length]');
  }
}
