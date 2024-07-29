import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:open_words/collection/list_randomizer.dart';
import 'package:open_words/data/word/word.dart';
import 'package:open_words/view/game/guess_game/guess_game_game_end_dialog.dart';
import 'package:open_words/view/game/guess_game/word_compare/compare_body.dart';
import 'package:open_words/view/game/guess_game/word_compare/compare_game.dart';

import '../word_question_side.dart';

class CompareGameView extends StatefulWidget {
  final List<Word> words;
  final WordQuestionSide wordSide;

  const CompareGameView({
    super.key,
    required this.words,
    required this.wordSide,
  });

  const CompareGameView.origins({
    super.key,
    required this.words,
  }) : wordSide = WordQuestionSide.origin;
  const CompareGameView.translations({
    super.key,
    required this.words,
  }) : wordSide = WordQuestionSide.translation;

  @override
  State<CompareGameView> createState() => _CompareGameViewState();
}

class _CompareGameViewState extends State<CompareGameView> {
  late final CompareGame game;

  @override
  void initState() {
    super.initState();

    game = CompareGame.create(
      words: widget.words.toList()..randomize(times: 4),
      metadataStorage: GetIt.I.get(),
      questionSide: widget.wordSide,
      onGameEnd: () => game.showGameEndDialogDeleyed(context, setState),
      onMetadataLoaded: _onMetadataLoaded,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CompareBody(
          game: game,
          helpers: game.helpers,
          onHelpTap: _onHelpTap,
          onAnswerTap: _onAnswerTap,
          onPrevTap: () {
            setState(() {
              game
                ..prev()
                ..updateState();
            });
          },
          onNextTap: () {
            setState(() {
              game
                ..next()
                ..updateState();
            });
          },
        ),
      ),
    );
  }

  void _onHelpTap() {
    setState(() {
      game.helpers.request();
    });
  }

  void _onAnswerTap(Word answer, int index) async {
    setState(() {
      final quiz = game.currentQuiz;

      game.answer(
        question: quiz.getQuestionText(),
        correctAnswer: quiz.getCorrectAnswerText(),
        userAnswer: quiz.getVariantTextAt(index),
      );
    });
  }

  void _onMetadataLoaded() => setState(() {});
}
