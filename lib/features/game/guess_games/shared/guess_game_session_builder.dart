import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:open_words/core/services/logger/app_logger.dart';
import 'package:open_words/features/game/guess_games/shared/guess_game_repository_builder.dart';
import 'package:open_words/features/game/guess_games/shared/guess_game_session.dart';
import 'package:open_words/features/game/guess_games/shared/guess_game_session_validator.dart';
import 'package:open_words/features/game/shared/quiz/quiz_exports.dart';

abstract class GuessGameSessionBuilder<
  TSession extends GuessGameSession<TQuizItem, TSession>,
  TQuizItem extends QuizItem
> {
  GuessGameSessionValidator get sessionValidator;
  GuessGameRepositoryBuilder<TQuizItem> get repositoryBuilder;

  const GuessGameSessionBuilder();

  @protected
  TSession buildSession();

  @nonVirtual
  TSession build() {
    throwIfNotEnoughWords();

    return buildSession();
  }

  @nonVirtual
  void throwIfNotEnoughWords() {
    if (sessionValidator.isIncorrect()) {
      final error = 'Not enough words to generate the requested quiz size.';

      GetIt.I.get<AppLogger>().f(error);

      throw StateError(error);
    }
  }
}
