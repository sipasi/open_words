import 'package:flutter/material.dart';
import 'package:open_words/view/game/guess_game/match_pairs/expanded_column.dart';
import 'package:open_words/view/game/guess_game/match_pairs/word_pairs_game.dart';

import '../word_guess_screen.dart';

class PairsView extends StatelessWidget {
  final WordPairsGame game;

  final Widget Function(int index) questionBuilder;
  final Widget Function(int index) variantBuilder;

  final void Function() onGameExitTap;
  final void Function() onNextPackTap;
  final void Function() onPrevPackTap;

  const PairsView({
    super.key,
    required this.game,
    required this.questionBuilder,
    required this.variantBuilder,
    required this.onGameExitTap,
    required this.onNextPackTap,
    required this.onPrevPackTap,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: WordGuessScreen(
          game: game,
          screenMargin: const EdgeInsets.symmetric(horizontal: 20).copyWith(bottom: 30),
          bodyBuilder: (context) => Expanded(
            child: Row(
              children: [
                ExpandedColumn(
                  length: game.currentQuiz.count,
                  builder: (index) => questionBuilder(index),
                ),
                ExpandedColumn(
                  length: game.currentQuiz.count,
                  builder: (index) => variantBuilder(index),
                ),
              ],
            ),
          ),
          onPrev: onPrevPackTap,
          onNext: onNextPackTap,
        ),
      ),
    );
  }
}
