import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:open_words/core/collection/list_random_extension.dart';
import 'package:open_words/core/data/entities/word/word.dart';
import 'package:open_words/core/services/logger/app_logger.dart';
import 'package:open_words/features/game/guess_games/word_pairs/models/pairs_match_quiz_item.dart';
import 'package:open_words/features/game/guess_games/word_pairs/models/pairs_match_session.dart';
import 'package:open_words/features/game/guess_games/word_pairs/models/pairs_part.dart';
import 'package:open_words/features/game/shared/quiz/quiz_exports.dart';

final class PairsMatchSessionBuilder {
  final List<Word> words;

  final QuizSize quizSize;

  final QuizQuestionSide questionSide;

  const PairsMatchSessionBuilder({
    required this.words,
    required this.quizSize,
    required this.questionSide,
  });

  const PairsMatchSessionBuilder.originQuestionSide({
    required this.words,
    required this.quizSize,
  }) : questionSide = QuizQuestionSide.origin;

  const PairsMatchSessionBuilder.translationQuestionSide({
    required this.words,
    required this.quizSize,
  }) : questionSide = QuizQuestionSide.translation;

  Future<PairsMatchSession> build() async {
    if (words.length < quizSize.preferredSize) {
      final error = 'Not enough words to generate the requested quiz size.';

      GetIt.I.get<AppLogger>().f(error);

      return const PairsMatchSession();
    }

    final session = PairsMatchSession(
      repository: createRepository(
        words: words,
        questionSide: questionSide,
        quizSize: quizSize,
        pairsPerQuiz: 5,
      ),
    );

    return session;
  }

  static QuizRepository<PairsMatchQuizItem> createRepository({
    required List<Word> words,
    required QuizQuestionSide questionSide,
    required QuizSize quizSize,
    required int pairsPerQuiz,
  }) {
    final wordsTemp = words.toList()..randomize();
    final quizCount = (quizSize.preferredSize / pairsPerQuiz).ceil();
    final quizes = <PairsMatchQuizItem>[];

    for (var i = 0, skipped = 0; i < quizCount; i++) {
      final questions = <QuestionPart>[];
      final variants = <AnswerPart>[];

      for (var word in wordsTemp.skip(skipped).take(pairsPerQuiz)) {
        questions.add(QuestionPart(word: word, side: questionSide));
        variants.add(AnswerPart(word: word, side: questionSide));

        skipped++;

        if (skipped == quizSize.preferredSize) {
          break;
        }
      }

      quizes.add(
        PairsMatchQuizItem(
          questions: questions..randomize(),
          variants: variants..randomize(),
        ),
      );
    }
    // Shuffle the quiz list multiple times to increase randomness
    return QuizRepository(quizes);
  }
}
