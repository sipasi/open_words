import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:open_words/data/language_info.dart';
import 'package:open_words/data/word/word_group.dart';
import 'package:open_words/service/navigation/material_navigator.dart';
import 'package:open_words/service/text_to_speech_service.dart';
import 'package:open_words/view/game/dialog/game_end_dialog.dart';
import 'package:open_words/view/game/match_pairs/audio_pairs/audio_pair_button.dart';
import 'package:open_words/view/game/match_pairs/pairs_view.dart';
import 'package:open_words/view/game/match_pairs/text_pair_button.dart';
import 'package:open_words/view/game/match_pairs/word_pairs_game.dart';

class AudioPairsPage extends StatefulWidget {
  final WordGroup group;

  const AudioPairsPage({super.key, required this.group});

  @override
  State<StatefulWidget> createState() => _AudioPairsPageState();
}

class _AudioPairsPageState extends State<AudioPairsPage> {
  late final WordPairsGame game;

  @override
  void initState() {
    super.initState();

    game = WordPairsGame(
      words: widget.group.words,
      onCorrectAnswer: () {},
      onWrongAnswer: () {},
      onGameEnd: () => _onGameEnd(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pairs = game.current;

    return PairsView(
      title: 'Find audio pairs',
      pairsCount: pairs.count,
      answeredPairsPercentage: game.answeredPairsPercentage,
      lastPack: game.lastPack,
      currentCompleted: pairs.completed,
      originBuilder: (index) => AudioPairButton(
        card: pairs.originAt(index),
        onTap: () {
          _speechWord(pairs.originAt(index).text, widget.group.origin);

          setState(() => game.selectOrigin(index));
        },
      ),
      translationBuilder: (index) => TextPairButton(
        card: pairs.translationAt(index),
        onTap: () => setState(() => game.selectTranslation(index)),
      ),
      onGameExitTap: () => MaterialNavigator.pop(context),
      onNextPackTap: () => setState(() => game.tryNextPack()),
    );
  }

  static Future _speechWord(String text, LanguageInfo language) async {
    final textToSpeech = GetIt.I.get<TextToSpeechService>();

    await textToSpeech.stop();
    await textToSpeech.speak(text, language);
  }

  Future _onGameEnd() {
    return GameEndDialog.show(
      context: context,
      onResults: () {},
      onRestart: () {},
      onExit: () {
        MaterialNavigator.pop(context, times: 2);
      },
    );
  }
}
