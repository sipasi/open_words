import 'package:flutter/material.dart';
import 'package:open_words/data/word/word_group.dart';
import 'package:open_words/service/navigation/material_navigator.dart';
import 'package:open_words/view/game/guess_game/guess_game_game_end_dialog.dart';
import 'package:open_words/view/game/guess_game/match_pairs/pairs_view.dart';
import 'package:open_words/view/game/guess_game/match_pairs/word_pairs/text_pair_button.dart';
import 'package:open_words/view/game/guess_game/match_pairs/word_pairs_game.dart';

class WordPairsPage extends StatefulWidget {
  final WordGroup group;

  const WordPairsPage({super.key, required this.group});

  @override
  State<StatefulWidget> createState() => _WordPairsPageState();
}

class _WordPairsPageState extends State<WordPairsPage> {
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

        return TextPairButton(
          text: part.text,
          selected: part.selected,
          readonly: part.solved,
          onTap: () => setState(() => game.selectQuestion(index)),
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
}
