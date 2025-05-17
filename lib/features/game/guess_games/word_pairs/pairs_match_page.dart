import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:open_words/core/data/entities/language_info.dart';
import 'package:open_words/features/game/guess_games/word_pairs/cubit/pairs_match_cubit.dart';
import 'package:open_words/features/game/guess_games/word_pairs/models/pairs_match_type.dart';
import 'package:open_words/features/game/guess_games/word_pairs/utils/pairs_match_evaluator.dart';
import 'package:open_words/features/game/guess_games/word_pairs/utils/pairs_match_session_builder.dart';
import 'package:open_words/features/game/guess_games/word_pairs/widgets/word_pairs_list_view.dart';
import 'package:open_words/features/game/guess_games/word_pairs/widgets/word_pairs_quiz_score_view.dart';
import 'package:open_words/features/game/quiz_end/models/quiz_end_result.dart';
import 'package:open_words/features/game/quiz_end/quiz_end_page.dart';
import 'package:open_words/shared/appbar/app_bar_title.dart';
import 'package:open_words/shared/navigation/material_navigator.dart';

class PairsMatchPage extends StatelessWidget {
  final LanguageInfo origin;
  final LanguageInfo translation;

  final PairsMatchSessionBuilder sessionBuilder;

  final PairsMatchType matchType;

  const PairsMatchPage.wordPairs({super.key, required this.sessionBuilder})
    : matchType = PairsMatchType.wordToWord,
      origin = const LanguageInfo.empty(),
      translation = const LanguageInfo.empty();
  const PairsMatchPage.audioPairs({
    super.key,
    required this.sessionBuilder,
    required this.origin,
    required this.translation,
  }) : matchType = PairsMatchType.audioToWord;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return PairsMatchCubit(
          wordStatisticRepository: GetIt.I.get(),
          origin: origin,
          translation: translation,
          textToSpeech: GetIt.I.get(),
          sessionBuilder: sessionBuilder,
          matchEvaluator: const PairsMatchEvaluator(),
          matchType: matchType,
        )..started();
      },
      child: BlocListener<PairsMatchCubit, PairsMatchState>(
        listener: _listener,
        child: PairsMatchView(),
      ),
    );
  }

  void _listener(BuildContext context, PairsMatchState state) async {
    if (state.gameStatus.isGameEnd) {
      final bloc = context.read<PairsMatchCubit>();

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

class PairsMatchView extends StatelessWidget {
  const PairsMatchView({super.key});

  @override
  Widget build(BuildContext context) {
    final status = context.select(
      (PairsMatchCubit value) => value.state.gameStatus,
    );

    if (status.isNotStarted) {
      return Scaffold(
        appBar: AppBar(title: AppBarTitle(title: 'Word Pairs Match')),
      );
    }

    return Scaffold(
      appBar: AppBar(title: AppBarTitle(title: 'Word Pairs Match')),
      body: SafeArea(
        child: Column(
          children: [WordPairsQuizScoreView(), WordPairsListView()],
        ),
      ),
    );
  }
}
