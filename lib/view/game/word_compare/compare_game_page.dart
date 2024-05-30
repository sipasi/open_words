import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:open_words/data/metadata/word_metadata.dart';
import 'package:open_words/data/word/word.dart';
import 'package:open_words/data/word/word_group.dart';
import 'package:open_words/storage/metadata_storage.dart';
import 'package:open_words/view/game/word_compare/compare_game_view.dart';
import 'package:open_words/view/game/word_compare/game_score_data.dart';
import 'package:open_words/view/game/word_compare/word_text_getter.dart';
import 'package:open_words/view/shared/future_scaffold_state.dart';

class CompareGamePage extends StatefulWidget {
  final WordGroup group;
  final WordTextGetter textGetter;

  const CompareGamePage({
    super.key,
    required this.group,
    required this.textGetter,
  });

  @override
  State<CompareGamePage> createState() => _CompareGamePageState();
}

class _CompareGamePageState extends FutureScaffoldState<CompareGamePage, GameScoreData> {
  @override
  Future<GameScoreData> getFuture() async {
    final words = widget.group.words.toList(growable: false)..shuffle();

    final storage = GetIt.I.get<MetadataStorage>();

    Map<Word, WordMetadata> metadatas = {};

    for (var word in words) {
      final metadata = await storage.firstByWord(word.origin);

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
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: CompareGameView(
          words: data.words,
          map: data.metadatas,
          textGetter: widget.textGetter,
        ),
      ),
    );
  }

  @override
  AppBar appbarBuild(BuildContext context, ConnectionState state) {
    return AppBar(
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
    );
  }
}
