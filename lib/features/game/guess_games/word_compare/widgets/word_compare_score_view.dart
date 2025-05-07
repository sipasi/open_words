import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_words/features/game/guess_games/word_compare/bloc/word_compare_bloc.dart';
import 'package:open_words/features/game/shared/widgets/quiz_score_view.dart';

class WordCompareScoreView extends StatelessWidget {
  const WordCompareScoreView({super.key});

  @override
  Widget build(BuildContext context) {
    final score = context.select((WordCompareBloc value) => value.state.score);

    return QuizScoreView(score: score);
  }
}
