import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:open_words/data/word/word.dart';
import 'package:open_words/data/word/word_group.dart';
import 'package:open_words/storage/word_group_storage.dart';
import 'package:open_words/view/shared/tile/custom_tile.dart';
import 'package:open_words/view/word/detail/word_detail_page.dart';
import 'package:open_words/view/word_group/edit/word_group_edit_page.dart';

import '../../shared/dialog/word_create_dialog.dart';

class WordGroupDetailPage extends StatefulWidget {
  final WordGroup group;

  const WordGroupDetailPage({super.key, required this.group});

  @override
  State<WordGroupDetailPage> createState() => _WordGroupDetailPageState();
}

class _WordGroupDetailPageState extends State<WordGroupDetailPage> {
  late WordGroup modified;

  @override
  void initState() {
    super.initState();

    final group = widget.group;

    modified = group.copyWith(words: group.words.toList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(modified.name),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context, modified),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_note_outlined),
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (builder) => WordGroupEditPage(group: modified),
                ),
              );

              if (result == null) {
                return;
              }
              setState(() {
                modified = result;
              });

              await GetIt.I.get<WordGroupStorage>().set(result.id, result);
            },
          ),
          IconButton(
            icon: const Icon(Icons.games_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: _justGrid(context, modified.words),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          final created = await WordCreateDialog.show(context: context, parent: modified);

          if (created.isEmpty) {
            return;
          }

          setState(() {
            modified.words.addAll(created);
          });

          await GetIt.I.get<WordGroupStorage>().set(modified.id, modified);
        },
      ),
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
                originLanguage: modified.origin,
                translationLanguage: modified.translation,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
