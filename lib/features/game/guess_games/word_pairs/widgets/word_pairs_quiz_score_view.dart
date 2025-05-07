import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_words/features/game/guess_games/word_pairs/cubit/pairs_match_cubit.dart';
import 'package:open_words/features/game/shared/widgets/quiz_score_view.dart';

class WordPairsQuizScoreView extends StatelessWidget {
  const WordPairsQuizScoreView({super.key});

  @override
  Widget build(BuildContext context) {
    final score = context.select((PairsMatchCubit value) => value.state.score);

    return QuizScoreView(score: score);
  }
}
