import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_words/features/game/guess_games/word_compare/bloc/word_compare_bloc.dart';
import 'package:open_words/features/game/guess_games/word_compare/utils/compare_session_builder.dart';
import 'package:open_words/features/game/guess_games/word_compare/widgets/word_compare_answer_view.dart';
import 'package:open_words/features/game/guess_games/word_compare/widgets/word_compare_question_view.dart';
import 'package:open_words/features/game/guess_games/word_compare/widgets/word_compare_score_view.dart';
import 'package:open_words/features/game/quiz_end/models/quiz_end_result.dart';
import 'package:open_words/features/game/quiz_end/quiz_end_page.dart';
import 'package:open_words/shared/appbar/app_bar_title.dart';
import 'package:open_words/shared/navigation/material_navigator.dart';

class WordCompareGamePage extends StatelessWidget {
  final CompareSessionBuilder sessionBuilder;

  const WordCompareGamePage({super.key, required this.sessionBuilder});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return WordCompareBloc(sessionBuilder: sessionBuilder)
          ..add(WordCompareStarted());
      },
      child: BlocListener<WordCompareBloc, WordCompareState>(
        listener: _listener,
        child: WordCompareGameView(),
      ),
    );
  }

  void _listener(BuildContext context, WordCompareState state) async {
    if (state.gameStatus.isGameEnd) {
      final bloc = context.read<WordCompareBloc>();

      final result = await context.pushDelayed<QuizEndResult>(
        (context) => QuizEndPage(
          history: bloc.state.answerHistory,
          score: bloc.state.score,
        ),
        duration: const Duration(milliseconds: 800),
      );

      if (!context.mounted) return;

      result.onSuccess(
        (value) => switch (value) {
          QuizEndResult.exit => context.pop(),
          QuizEndResult.restart => bloc.add(WordCompareStarted()),
        },
      );

      result.onEmpty(context.pop);
    }
  }
}

class WordCompareGameView extends StatelessWidget {
  const WordCompareGameView({super.key});

  @override
  Widget build(BuildContext context) {
    final gameStatus = context.select(
      (WordCompareBloc value) => value.state.gameStatus,
    );

    if (gameStatus.isNotStarted) {
      return Scaffold(
        appBar: AppBar(title: AppBarTitle(title: 'Word Compare Game')),
      );
    }

    return Scaffold(
      appBar: AppBar(title: AppBarTitle(title: 'Word Compare Game')),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            WordCompareScoreView(),
            const Spacer(),
            WordCompareQuestionView(),
            WordCompareAnswerView(),
          ],
        ),
      ),
    );
  }
}
