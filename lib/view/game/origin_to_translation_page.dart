import 'package:flutter/material.dart';
import 'package:open_words/data/metadata/word_metadata.dart';
import 'package:open_words/data/word/word.dart';
import 'package:open_words/view/shared/future_scaffold_state.dart';

import 'word_compare_game.dart';

class OriginToTranslationPage extends StatefulWidget {
  const OriginToTranslationPage({super.key});

  @override
  State<OriginToTranslationPage> createState() => _OriginToTranslationPageState();
}

class GameScoreData {
  final List<Word> words;
  final Map<Word, WordMetadata> metadatas;

  GameScoreData({required this.words, required this.metadatas});
}

class _OriginToTranslationPageState extends FutureScaffoldState<OriginToTranslationPage, GameScoreData> {
  @override
  Future<GameScoreData> getFuture() async {
    await Future.delayed(Duration(seconds: 1));

    final data = GameScoreData(
        words: List.generate(
          10,
          (index) => Word(
            origin: 'origin $index',
            translation: 'translation $index',
            index: index,
          ),
        )..shuffle(),
        metadatas: {});

    return data;
  }

  @override
  Widget successBuild(BuildContext context, GameScoreData data) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: WordCompareGame(
        words: data.words,
        metadatas: data.metadatas,
        wordText: (word) => word.origin,
        buttonText: (word) => word.translation,
      ),
    );
  }

  @override
  AppBar appbarBuild(BuildContext context, ConnectionState state) {
    return AppBar();
  }
}
