import 'package:flutter/material.dart';
import 'package:open_words/data/word/word_group.dart';
import 'package:open_words/service/navigation/material_navigator.dart';
import 'package:open_words/view/game/dialog/game_end_dialog.dart';
import 'package:open_words/view/game/match_pairs/pairs_view.dart';
import 'package:open_words/view/game/match_pairs/text_pair_button.dart';
import 'package:open_words/view/game/match_pairs/word_pairs_game.dart';

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
      title: 'Find word pairs',
      pairsCount: pairs.count,
      answeredPairsPercentage: game.answeredPairsPercentage,
      lastPack: game.lastPack,
      currentCompleted: pairs.completed,
      originBuilder: (index) => TextPairButton(
        card: pairs.originAt(index),
        onTap: () => setState(() => game.selectOrigin(index)),
      ),
      translationBuilder: (index) => TextPairButton(
        card: pairs.translationAt(index),
        onTap: () => setState(() => game.selectTranslation(index)),
      ),
      onGameExitTap: () => MaterialNavigator.pop(context),
      onNextPackTap: () => setState(() => game.tryNextPack()),
    );
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
