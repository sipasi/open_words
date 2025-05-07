import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_words/features/game/guess_games/word_compare/bloc/word_compare_bloc.dart';
import 'package:open_words/features/game/guess_games/word_compare/widgets/compare_animated_word.dart';

class WordCompareQuestionView extends StatelessWidget {
  const WordCompareQuestionView({super.key});
  @override
  Widget build(BuildContext context) {
    final session = context.select(
      (WordCompareBloc value) => value.state.session,
    );

    return CompareAnimatedWord(
      leavedWord: session.beforeQuiz?.getQuestionText(),
      arrivedWord: session.currentQuiz.getQuestionText(),
      lastWord: session.allQuizFinished,
    );
  }
}
