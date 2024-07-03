import 'package:flutter/material.dart';
import 'package:open_words/data/word/word.dart';
import 'package:open_words/data/word/word_group.dart';
import 'package:open_words/view/shared/button/rectangle_style.dart';
import 'package:open_words/view/shared/list/adaptive_grid_view.dart';
import 'package:open_words/view/shared/tile/text_tile.dart';
import 'package:open_words/view/word_group/detail/word_group_detail_view_model.dart';

class WordGroupDetailPage extends StatefulWidget {
  final WordGroup group;

  final int heroIndex;

  const WordGroupDetailPage({super.key, required this.group, required this.heroIndex});

  @override
  State<WordGroupDetailPage> createState() => _WordGroupDetailPageState();
}

class _WordGroupDetailPageState extends State<WordGroupDetailPage> {
  late final WordGroupDetailViewModel viewmodel;

  @override
  void initState() {
    super.initState();

    viewmodel = WordGroupDetailViewModel(widget.group.clone());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          viewmodel.name,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => viewmodel.navigateBack(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.update),
            onPressed: () => viewmodel.updateAllMetadatas(context),
          ),
          IconButton(
            icon: const Icon(Icons.delete_forever_outlined),
            onPressed: () => viewmodel.tryDelete(context),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => viewmodel.tryAddWords(context, setState),
      ),
      body: _grid(context),
    );
  }

  Widget _grid(BuildContext context) {
    return SafeArea(
      child: AdaptiveGridView(padding: const EdgeInsets.only(bottom: 120), children: [
        _filledButton(Icons.edit, 'Edit', () => viewmodel.tryEdit(context, setState)),
        _filledButton(Icons.gamepad, 'Games', () => viewmodel.navigateToGames(context)),
        ...List.generate(
          viewmodel.length,
          (index) {
            Word word = viewmodel.wordBy(index);

            return TextTile(
              title: word.origin,
              subtitle: word.translation,
              onTap: () => viewmodel.onTap(context, setState, index),
            );
          },
        ),
      ]),
    );
  }

  Widget _filledButton(IconData icon, String text, void Function() onTap) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: OutlinedButton.icon(
        onPressed: onTap,
        style: RectangleStyle.outlined(),
        icon: Icon(icon),
        label: Text(text),
      ),
    );
  }
}
