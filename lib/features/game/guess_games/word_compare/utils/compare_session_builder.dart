import 'package:get_it/get_it.dart';
import 'package:open_words/core/collection/list_random_extension.dart';
import 'package:open_words/core/data/entities/word/word.dart';
import 'package:open_words/core/services/logger/app_logger.dart';
import 'package:open_words/features/game/guess_games/word_compare/models/compare_quiz_item.dart';
import 'package:open_words/features/game/guess_games/word_compare/models/compare_session.dart';
import 'package:open_words/features/game/shared/quiz/quiz_exports.dart';

/// A builder class for creating [CompareSession] instances using a list of [Word]s.
///
/// This class provides multiple constructors to allow different configurations
/// for the quiz, such as selecting the side of the word used for questions.
/// It uses a builder pattern to encapsulate the logic for generating quiz items.
final class CompareSessionBuilder {
  /// The complete list of words from which questions and answers are derived.
  final List<Word> words;

  /// The desired size of the quiz, which determines how many questions to generate.
  final QuizSize quizSize;

  /// Specifies which side of the word (origin or translation) will be used as the question
  final QuizQuestionSide questionSide;

  const CompareSessionBuilder({
    required this.words,
    required this.quizSize,
    required this.questionSide,
  });

  /// Creates a [CompareSessionBuilder] that always uses the word's origin side as the question.
  const CompareSessionBuilder.originQuestionSide({
    required this.words,
    required this.quizSize,
  }) : questionSide = QuizQuestionSide.origin;

  /// Creates a [CompareSessionBuilder] that always uses the word's translation side as the question.
  const CompareSessionBuilder.translationQuestionSide({
    required this.words,
    required this.quizSize,
  }) : questionSide = QuizQuestionSide.translation;

  /// Builds and returns a new [CompareSession] using the provided configuration.
  ///
  /// It selects a random subset of words for questions based on the quiz size,
  /// and uses all words as the pool for answer options.
  Future<CompareSession> build() async {
    if (words.length < quizSize.preferredSize) {
      final error = 'Not enough words to generate the requested quiz size.';

      GetIt.I.get<AppLogger>().f(error);

      return CompareSession();
    }

    final session = CompareSession(
      repository: createRepository(
        questionsRange: words.getRandom(count: quizSize.preferredSize),
        answersRange: words,
        questionSide: questionSide,
      ),
    );

    return session;
  }

  /// Creates a [QuizRepository] containing a list of [CompareQuizItem]s,
  /// each consisting of a question and multiple randomized answer variants.
  ///
  /// - [questionsRange] is the list of words used as the basis for quiz questions.
  /// - [answersRange] is the pool of words from which answer variants are drawn.
  /// - [questionSide] defines whether the origin or translation side is used as the question.
  ///
  /// For each question in [questionsRange], four answer variants are randomly selected
  /// from [answersRange], excluding the correct answer to prevent duplication.
  /// The resulting list is shuffled multiple times to improve randomness.
  ///
  /// Throws an error if [answersRange] does not have enough distinct items to
  /// generate 4 answer variants excluding the current question.
  static QuizRepository<CompareQuizItem> createRepository({
    required List<Word> questionsRange,
    required List<Word> answersRange,
    required QuizQuestionSide questionSide,
  }) {
    final quizzes = List.generate(questionsRange.length, (index) {
      final question = questionsRange[index];
      final variants = answersRange.getRandom(count: 4, exclude: question);

      return CompareQuizItem(
        side: questionSide,
        question: question,
        variants: variants,
      );
    }, growable: false);

    // Shuffle the quiz list multiple times to increase randomness
    return QuizRepository(quizzes..randomize(times: 4));
  }
}
