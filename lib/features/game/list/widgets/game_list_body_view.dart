import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:open_words/core/services/logger/app_logger.dart';
import 'package:open_words/features/game/guess_games/word_compare/utils/compare_session_builder.dart';
import 'package:open_words/features/game/guess_games/word_compare/word_compare_game_page.dart';
import 'package:open_words/features/game/guess_games/word_constructor/utils/word_constructor_session_builder.dart';
import 'package:open_words/features/game/guess_games/word_constructor/word_constructor_page.dart';
import 'package:open_words/features/game/guess_games/word_pairs/pairs_match_page.dart';
import 'package:open_words/features/game/guess_games/word_pairs/utils/pairs_match_session_builder.dart';
import 'package:open_words/features/game/list/cubit/game_list_cubit.dart';
import 'package:open_words/features/game/list/widgets/game_list_tile.dart';
import 'package:open_words/features/game/list/widgets/game_list_tile_section.dart';
import 'package:open_words/features/game/shared/quiz/quiz_size.dart';

class GameListBodyView extends StatelessWidget {
  const GameListBodyView({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<GameListCubit>();

    return ListView(
      padding: const EdgeInsets.only(bottom: 124),
      children: [
        _compareSection(bloc),
        _matchSection(bloc),
        _constructorSection(bloc),
      ],
    );
  }

  Widget _compareSection(GameListCubit bloc) {
    final words = bloc.words;

    return GameListTileSection(
      title: 'Compare',
      tiles: [
        GameListTile(
          name: 'Origins',
          description: 'Compare original words to translations',
          words: words.length,
          wordsNeed: 8,
          route: (builder) {
            return WordCompareGamePage(
              sessionBuilder: CompareSessionBuilder.originQuestionSide(
                words: words,
                quizSize: getQuizSize(bloc: bloc, allowedMin: 8),
              ),
            );
          },
        ),
        GameListTile(
          name: 'Translations',
          description: 'Compare translations to their original words',
          words: words.length,
          wordsNeed: 8,
          route: (builder) {
            return WordCompareGamePage(
              sessionBuilder: CompareSessionBuilder.translationQuestionSide(
                words: words,
                quizSize: getQuizSize(bloc: bloc, allowedMin: 8),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _matchSection(GameListCubit bloc) {
    final words = bloc.words;

    return GameListTileSection(
      title: 'Match',
      tiles: [
        GameListTile(
          name: 'Word Pairs',
          description: 'Match original words to translations',
          words: words.length,
          wordsNeed: 5,
          route: (builder) {
            return PairsMatchPage.wordPairs(
              sessionBuilder: PairsMatchSessionBuilder.originQuestionSide(
                words: words,
                quizSize: getQuizSize(bloc: bloc, allowedMin: 5),
              ),
            );
          },
        ),
        GameListTile(
          name: 'Audio Pairs',
          description: 'Match audio clips with translations',
          words: words.length,
          wordsNeed: 5,
          route: (builder) {
            return PairsMatchPage.audioPairs(
              sessionBuilder: PairsMatchSessionBuilder.originQuestionSide(
                words: words,
                quizSize: getQuizSize(bloc: bloc, allowedMin: 5),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _constructorSection(GameListCubit bloc) {
    final words = bloc.words;

    return GameListTileSection(
      title: 'Constructor',
      tiles: [
        GameListTile(
          name: 'Origins',
          description: 'Create words from given parts or letters',
          words: words.length,
          wordsNeed: 5,
          route: (builder) {
            return WordConstructorPage(
              sessionBuilder: WordConstructorSessionBuilder.originQuestionSide(
                words: words,
                quizSize: getQuizSize(bloc: bloc, allowedMin: 5),
              ),
            );
          },
        ),
        GameListTile(
          name: 'Translations',
          description: 'Create words from given parts or letters',
          words: words.length,
          wordsNeed: 5,
          // route: (builder) => WordConstructorPage.constructTranslations(group: group),
        ),
      ],
    );
  }

  QuizSize getQuizSize({required GameListCubit bloc, required int allowedMin}) {
    final range = bloc.state.wordRange;
    final length = bloc.words.length;

    if (range.selectedMax) {
      return QuizSize.max(allowedMin: allowedMin, allowedMax: length);
    }
    if (range.selectedMin) {
      return QuizSize.min(allowedMin: allowedMin, allowedMax: length);
    }

    if (range.selectedValue < allowedMin) {
      GetIt.I.get<AppLogger>().e(
        '[GameListView.getQuizSize] - range.selectedValue < allowedMin',
      );
    }

    return QuizSize.custom(
      allowedMin: allowedMin,
      allowedMax: length,
      preferred: range.selectedValue.toInt(),
    );
  }
}
