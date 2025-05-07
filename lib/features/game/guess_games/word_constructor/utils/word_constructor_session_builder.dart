import 'package:get_it/get_it.dart';
import 'package:open_words/core/collection/list_random_extension.dart';
import 'package:open_words/core/data/entities/word/word.dart';
import 'package:open_words/core/services/logger/app_logger.dart';
import 'package:open_words/features/game/guess_games/word_constructor/models/word_constructor_quiz_item.dart';
import 'package:open_words/features/game/guess_games/word_constructor/models/word_constructor_session.dart';
import 'package:open_words/features/game/guess_games/word_constructor/models/word_part.dart';
import 'package:open_words/features/game/shared/quiz/quiz_exports.dart';

class WordConstructorSessionBuilder {
  final List<Word> words;
  final QuizSize quizSize;

  final QuizQuestionSide questionSide;

  WordConstructorSessionBuilder.originQuestionSide({
    required this.words,
    required this.quizSize,
  }) : questionSide = QuizQuestionSide.origin;

  WordConstructorSessionBuilder.translationQuestionSide({
    required this.words,
    required this.quizSize,
  }) : questionSide = QuizQuestionSide.translation;

  Future<WordConstructorSession> build() async {
    if (words.length < quizSize.preferredSize) {
      final error = 'Not enough words to generate the requested quiz size.';

      GetIt.I.get<AppLogger>().f(error);

      return const WordConstructorSession();
    }

    final session = WordConstructorSession(
      repository: createRepository(
        words: words,
        questionSide: questionSide,
        quizSize: quizSize,
      ),
    );

    return session;
  }

  static QuizRepository<WordConstructorQuizItem> createRepository({
    required List<Word> words,
    required QuizQuestionSide questionSide,
    required QuizSize quizSize,
  }) {
    final wordsTemp = words.toList()..randomize();

    final quizes = <WordConstructorQuizItem>[];

    for (var i = 0; i < quizSize.preferredSize; i++) {
      final word = wordsTemp[i];

      final question = questionSide.question(word);
      final variant = questionSide.variant(word);

      final parts = <WordPart>[];

      for (int j = 0; j < variant.length; j += 2) {
        int end = (j + 2 < variant.length) ? j + 2 : variant.length;

        parts.add(WordPart(id: j, text: variant.substring(j, end)));
      }

      quizes.add(
        WordConstructorQuizItem(
          question: question,
          correctAnswer: variant,
          answerParts: parts..randomize(),
        ),
      );
    }
    // Shuffle the quiz list multiple times to increase randomness
    return QuizRepository(quizes);
  }
}
