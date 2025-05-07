import 'package:open_words/core/data/entities/word/word.dart';
import 'package:open_words/features/game/shared/quiz/quiz_exports.dart';

abstract class GuessGameSessionValidator {
  bool isIncorrect();

  static GuessGameSessionValidator base({
    required List<Word> words,
    required QuizSize quizSize,
  }) {
    return _GuessGameSessionValidatorDefault(words: words, quizSize: quizSize);
  }
}

final class _GuessGameSessionValidatorDefault
    extends GuessGameSessionValidator {
  final List<Word> words;
  final QuizSize quizSize;

  _GuessGameSessionValidatorDefault({
    required this.words,
    required this.quizSize,
  });

  @override
  bool isIncorrect() {
    return words.length < quizSize.preferredSize;
  }
}
