import 'package:flutter/material.dart';
import 'package:open_words/view/game/guess_game/guess_progress_bar.dart';
import 'package:open_words/view/game/guess_game/word_guess_game.dart';
import 'package:open_words/view/game/word_game_screen.dart';

class WordGuessScreen extends StatelessWidget {
  final WordGuessGame game;

  final WidgetBuilder bodyBuilder;
  final WidgetBuilder? helpersBuilder;
  final WidgetBuilder? landscapeDividerBuilder;

  final EdgeInsets bottomMargin;
  final EdgeInsets screenMargin;

  final WordGamePortraitBuilder? portraitBuilder;
  final WordGameLandscapeBuilder? landscapeBuilder;

  final void Function() onPrev;
  final void Function() onNext;

  const WordGuessScreen({
    super.key,
    required this.game,
    required this.bodyBuilder,
    required this.onPrev,
    required this.onNext,
    this.bottomMargin = const EdgeInsets.all(0),
    this.screenMargin = const EdgeInsets.all(0),
    this.helpersBuilder,
    this.landscapeDividerBuilder,
    this.portraitBuilder,
    this.landscapeBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return WordGameScreen(
      game: game,
      bodyBuilder: bodyBuilder,
      progressBuilder: (context) => GuessProgressBar.fromScore(score: game.score),
      bottomMargin: bottomMargin,
      screenMargin: screenMargin,
      helpersBuilder: helpersBuilder,
      landscapeBuilder: landscapeBuilder,
      landscapeDividerBuilder: landscapeDividerBuilder,
      portraitBuilder: portraitBuilder,
      onPrev: onPrev,
      onNext: onNext,
    );
  }
}
