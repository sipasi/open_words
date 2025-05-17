import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:open_words/features/game/guess_games/word_constructor/cubit/word_constructor_cubit.dart';
import 'package:open_words/features/game/guess_games/word_constructor/utils/word_constructor_session_builder.dart';
import 'package:open_words/features/game/guess_games/word_constructor/widgets/variant_parts_view.dart';
import 'package:open_words/features/game/guess_games/word_constructor/widgets/word_constructor_question_view.dart';
import 'package:open_words/features/game/guess_games/word_constructor/widgets/word_constructor_quiz_score_view.dart';
import 'package:open_words/features/game/quiz_end/models/quiz_end_result.dart';
import 'package:open_words/features/game/quiz_end/quiz_end_page.dart';
import 'package:open_words/shared/appbar/app_bar_title.dart';
import 'package:open_words/shared/navigation/material_navigator.dart';

class WordConstructorPage extends StatelessWidget {
  final WordConstructorSessionBuilder sessionBuilder;

  const WordConstructorPage({super.key, required this.sessionBuilder});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return WordConstructorCubit(
          wordStatisticRepository: GetIt.I.get(),
          sessionBuilder: sessionBuilder,
        )..started();
      },
      child: BlocListener<WordConstructorCubit, WordConstructorState>(
        listener: _listener,
        child: WordConstructorView(),
      ),
    );
  }

  void _listener(BuildContext context, WordConstructorState state) async {
    if (state.gameStatus.isGameEnd) {
      final bloc = context.read<WordConstructorCubit>();

      final result = await context.pushDelayed<QuizEndResult>(
        (context) => QuizEndPage(
          history: bloc.state.answerHistory,
          score: bloc.state.score,
        ),
        duration: const Duration(milliseconds: 600),
      );

      if (!context.mounted) return;

      result.onSuccess(
        (value) => switch (value) {
          QuizEndResult.exit => context.pop(),
          QuizEndResult.restart => bloc.started(),
        },
      );

      result.onEmpty(context.pop);
    }
  }
}

class WordConstructorView extends StatelessWidget {
  const WordConstructorView({super.key});

  @override
  Widget build(BuildContext context) {
    final gameStatus = context.select(
      (WordConstructorCubit value) => value.state.gameStatus,
    );

    if (gameStatus.isNotStarted) {
      return Scaffold(
        appBar: AppBar(title: AppBarTitle(title: 'Word Constructor')),
      );
    }

    return Scaffold(
      appBar: AppBar(title: AppBarTitle(title: 'Word Constructor')),
      body: Column(
        children: [
          WordConstructorQuizScoreView(),
          WordConstructorQuestionView(),
          const Spacer(),
          VariantPartsView(),
        ],
      ),
    );
  }
}
