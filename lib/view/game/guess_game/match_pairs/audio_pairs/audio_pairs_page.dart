import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:open_words/data/language_info.dart';
import 'package:open_words/data/word/word_group.dart';
import 'package:open_words/service/navigation/material_navigator.dart';
import 'package:open_words/service/text_to_speech_service.dart';
import 'package:open_words/view/game/guess_game/guess_game_game_end_dialog.dart';
import 'package:open_words/view/game/guess_game/match_pairs/audio_pairs/audio_pair_button.dart';
import 'package:open_words/view/game/guess_game/match_pairs/pairs_view.dart';
import 'package:open_words/view/game/guess_game/match_pairs/word_pairs/text_pair_button.dart';
import 'package:open_words/view/game/guess_game/match_pairs/word_pairs_game.dart';

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

    game = WordPairsGame.create(
      words: widget.group.words,
      onGameEnd: () => game.showGameEndDialogDeleyed(context, setState),
    );
  }

  @override
  Widget build(BuildContext context) {
    final quiz = game.currentQuiz;

    return PairsView(
      game: game,
      questionBuilder: (index) {
        final part = quiz.questionAt(index);

        return AudioPairButton(
          selected: part.selected,
          readonly: part.solved,
          onTap: () {
            _speechWord(part.text, widget.group.origin);

            setState(() => game.selectQuestion(index));
          },
        );
      },
      variantBuilder: (index) {
        final part = quiz.variantAt(index);

        return TextPairButton(
          text: part.text,
          selected: part.selected,
          readonly: part.solved,
          onTap: () => setState(() => game.selectVariant(index)),
        );
      },
      onGameExitTap: () => MaterialNavigator.pop(context),
      onPrevPackTap: () => setState(() => game.prev()),
      onNextPackTap: () => setState(() => game.next()),
    );
  }

  static Future _speechWord(String text, LanguageInfo language) async {
    final textToSpeech = GetIt.I.get<TextToSpeechService>();

    await textToSpeech.stop();
    await textToSpeech.speak(text, language);
  }
}
