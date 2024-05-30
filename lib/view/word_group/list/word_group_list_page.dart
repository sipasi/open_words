import 'package:flutter/material.dart';
import 'package:open_words/view/mvvm/view_model.dart';
import 'package:open_words/view/word_group/list/word_group_list_view_model.dart';
import 'package:open_words/view/shared/list/adaptive_grid_view.dart';
import 'package:open_words/view/shared/tile/text_tile.dart';

class WordGroupListPage extends StatefulView<WordGroupListViewModel> {
  const WordGroupListPage({super.key});

  @override
  ViewState<WordGroupListViewModel> createState() => _WordGroupListPageState();
}

class _WordGroupListPageState extends ViewState<WordGroupListViewModel> {
  @override
  Widget success(BuildContext context) {
    final groups = viewmodel.groups;

    return Scaffold(
      body: AdaptiveGridView(
        padding: const EdgeInsets.only(bottom: 120),
        children: List.generate(
          groups.length,
          (element) {
            int index = groups.length - element - 1;

            final group = groups[index];

            return TextTile(
              title: group.name,
              subtitle: group.words.length.toString(),
              onTap: () => viewmodel.toDetail(context, index, setState),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => viewmodel.toCreate(context, setState),
      ),
    );
  }
}
