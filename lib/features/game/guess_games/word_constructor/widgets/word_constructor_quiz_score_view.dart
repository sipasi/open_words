import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_words/features/game/guess_games/word_constructor/cubit/word_constructor_cubit.dart';
import 'package:open_words/features/game/shared/widgets/quiz_score_view.dart';

class WordConstructorQuizScoreView extends StatelessWidget {
  const WordConstructorQuizScoreView({super.key});

  @override
  Widget build(BuildContext context) {
    final score = context.select(
      (WordConstructorCubit value) => value.state.score,
    );

    return QuizScoreView(score: score);
  }
}
