import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:open_words/data/word/word.dart';
import 'package:open_words/data/word/word_group.dart';
import 'package:open_words/service/navigation/material_navigator.dart';
import 'package:open_words/service/result.dart';
import 'package:open_words/storage/word_group_storage.dart';
import 'package:open_words/view/game/game_list_page.dart';
import 'package:open_words/view/shared/list/adaptive_grid_view.dart';
import 'package:open_words/view/shared/tile/text_tile.dart';
import 'package:open_words/view/word/create/word_list_create_page.dart';
import 'package:open_words/view/word/detail/word_detail_page.dart';
import 'package:open_words/view/word_group/edit/word_group_edit_page.dart';

class WordGroupDetailPage extends StatefulWidget {
  final WordGroup group;

  final int heroIndex;

  const WordGroupDetailPage({super.key, required this.group, required this.heroIndex});

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
        title: Text(
          modified.name,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => MaterialNavigator.popWith(
            context,
            CrudResult.modify(modified),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_forever_outlined),
            onPressed: () async {
              await GetIt.I.get<WordGroupStorage>().delete(modified.id);

              MaterialNavigator.popWith(context, CrudResult.delete(modified));
            },
          ),
          IconButton(
            icon: const Icon(Icons.edit_note_outlined),
            onPressed: () async {
              final result = await MaterialNavigator.push<WordGroup>(
                context,
                (builder) => WordGroupEditPage(group: modified),
              );

              result.modified<WordGroup>((value) async {
                setState(() {
                  modified = value;
                });

                await GetIt.I.get<WordGroupStorage>().set(value.id, value);
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.games_outlined),
            onPressed: () => MaterialNavigator.push(
              context,
              (buider) => GameListPage(group: modified),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          final result = await MaterialNavigator.push(
            context,
            (context) => WordListCreatePage(
              name: modified.name,
              origin: modified.origin,
              translation: modified.translation,
              startIndex: modified.words.length,
            ),
          );

          result.created<List<Word>>((list) async {
            if (list.isEmpty) {
              return;
            }

            setState(() {
              modified.words.addAll(list);
            });

            await GetIt.I.get<WordGroupStorage>().set(modified.id, modified);
          });
        },
      ),
      body: _justGrid(context, modified.words),
    );
  }

  Widget _justGrid(BuildContext context, List<Word> words) {
    return SafeArea(
      child: AdaptiveGridView(
        padding: const EdgeInsets.only(bottom: 120),
        children: List.generate(
          words.length,
          (index) => TextTile(
            title: words[index].origin,
            subtitle: words[index].translation,
            onTap: () => onTap(words, index),
          ),
        ),
      ),
    );
  }

  Future onTap(List<Word> words, int index) async {
    final result = await MaterialNavigator.push(
      context,
      (builder) => WordDetailPage(
        word: words[index],
        originLanguage: modified.origin,
        translationLanguage: modified.translation,
      ),
    );

    result.modified<Word>((word) async {
      setState(() {
        words.removeAt(index);
        words[index] = words[index].copyWith(index: index);
      });
      await GetIt.I.get<WordGroupStorage>().set(modified.id, modified);
    });

    result.deleted<Word>((_) async {
      setState(() {
        words.removeAt(index);

        modified = modified.copyWith(
          words: words
              .asMap()
              .entries
              .map(
                (entry) => Word(
                  origin: entry.value.origin,
                  translation: entry.value.translation,
                  index: entry.key,
                ),
              )
              .toList(),
        );
      });
      await GetIt.I.get<WordGroupStorage>().set(modified.id, modified);
    });
  }
}
