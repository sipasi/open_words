import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:open_words/data/metadata/word_metadata.dart';
import 'package:open_words/data/word/word.dart';
import 'package:open_words/data/word/word_group.dart';
import 'package:open_words/storage/metadata_storage.dart';
import 'package:open_words/view/game/word_compare/game_score_data.dart';
import 'package:open_words/view/game/word_compare/word_compare_game.dart';
import 'package:open_words/view/shared/future_scaffold_state.dart';

class WordCompareGamePage extends StatefulWidget {
  final WordGroup group;
  final String Function(Word word) questionText;
  final String Function(Word word) answerText;

  const WordCompareGamePage({
    super.key,
    required this.group,
    required this.questionText,
    required this.answerText,
  });

  @override
  State<WordCompareGamePage> createState() => _WordCompareGamePageState();
}

class _WordCompareGamePageState extends FutureScaffoldState<WordCompareGamePage, GameScoreData> {
  @override
  Future<GameScoreData> getFuture() async {
    final words = widget.group.words.toList(growable: false)..shuffle();

    final storage = GetIt.I.get<MetadataStorage>();

    Map<Word, WordMetadata> metadatas = {};

    for (var word in words) {
      final metadata = await storage.getBy(word.origin);

      if (metadata == null) {
        continue;
      }

      metadatas[word] = metadata;
    }

    final data = GameScoreData(
      words: words,
      metadatas: metadatas,
    );

    return data;
  }

  @override
  Widget successBuild(BuildContext context, GameScoreData data) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: WordCompareGame(
        words: data.words,
        metadatas: data.metadatas,
        questionText: widget.questionText,
        answerText: widget.answerText,
      ),
    );
  }

  @override
  AppBar appbarBuild(BuildContext context, ConnectionState state) {
    return AppBar();
  }
}
