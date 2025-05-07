import 'package:open_words/core/data/entities/word/word.dart';
import 'package:open_words/features/game/guess_games/shared/guess_game_session.dart';
import 'package:open_words/features/game/guess_games/shared/guess_game_session_builder.dart';
import 'package:open_words/features/game/guess_games/shared/guess_game_session_validator.dart';
import 'package:open_words/features/game/shared/quiz/quiz_exports.dart';

abstract class GuessGameSessionBuilderShared<
  TSession extends GuessGameSession<TQuizItem, TSession>,
  TQuizItem extends QuizItem
>
    extends GuessGameSessionBuilder<TSession, TQuizItem> {
  final List<Word> words;
  final QuizSize quizSize;
  final QuizQuestionSide questionSide;

  const GuessGameSessionBuilderShared({
    required this.words,
    required this.quizSize,
    required this.questionSide,
  });

  @override
  GuessGameSessionValidator get sessionValidator {
    return GuessGameSessionValidator.base(words: words, quizSize: quizSize);
  }
}
