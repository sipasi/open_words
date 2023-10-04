import 'package:flutter/material.dart';
import 'package:open_words/data/word/word.dart';
import 'package:open_words/data/word/word_group.dart';
import 'package:open_words/view/shared/tile/custom_tile.dart';
import 'package:open_words/view/word/detail/word_detail_page.dart';
import 'package:open_words/view/word_group/edit/word_group_edit_page.dart';

class WordGroupDetailPage extends StatefulWidget {
  final WordGroup group;

  const WordGroupDetailPage({super.key, required this.group});

  @override
  State<WordGroupDetailPage> createState() => _WordGroupDetailPageState();
}

class _WordGroupDetailPageState extends State<WordGroupDetailPage> {
  @override
  Widget build(BuildContext context) {
    final group = widget.group;
    final words = group.words;

    return Scaffold(
      appBar: AppBar(
        title: Text(group.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_note_outlined),
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (builder) => WordGroupEditPage(group: group),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.games_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: _justGrid(context, words),
    );
  }

  Widget _justGrid(BuildContext context, List<Word> words) {
    return GridView.count(
      crossAxisCount: 2,
      padding: EdgeInsets.zero,
      childAspectRatio: 2.3,
      children: List.generate(
        words.length,
        (index) => CustomTile(
          title: words[index].origin,
          subtitle: words[index].translation,
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (builder) => WordDetailPage(
                word: words[index],
                originLanguage: widget.group.origin,
                translationLanguage: widget.group.translation,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
