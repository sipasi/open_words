import 'dart:math';

import 'package:open_words/core/collection/list_random_extension.dart';
import 'package:open_words/core/data/entities/word/word.dart';
import 'package:open_words/features/game/guess_games/word_pairs/models/pairs_match_quiz_item.dart';
import 'package:open_words/features/game/guess_games/word_pairs/models/pairs_part.dart';
import 'package:open_words/features/game/shared/quiz/quiz_exports.dart';

final class PairsMatchQuizItemGenerator {
  final List<Word> shuffledWords;

  final QuizSize quizSize;
  final QuizQuestionSide questionSide;

  final int pairsPerQuiz;

  PairsMatchQuizItemGenerator({
    required this.shuffledWords,
    required this.quizSize,
    required this.questionSide,
    required this.pairsPerQuiz,
  });

  List<PairsMatchQuizItem> generate() {
    final quizCount = _calculateQuizCount();

    int wordsUsed = 0;

    return List.generate(quizCount, (_) {
      final takeCount = _needTake(wordsUsed: wordsUsed);

      final chunk = shuffledWords.skip(wordsUsed).take(takeCount);

      final item = _itemFromChunk(chunk);

      wordsUsed += takeCount;

      return item;
    });
  }

  int _calculateQuizCount() => (quizSize.preferredSize / pairsPerQuiz).ceil();

  PairsMatchQuizItem _itemFromChunk(Iterable<Word> chunk) {
    final questions = <QuestionPart>[];
    final variants = <AnswerPart>[];

    for (final word in chunk) {
      questions.add(QuestionPart(word: word, side: questionSide));
      variants.add(AnswerPart(word: word, side: questionSide));
    }

    return PairsMatchQuizItem(
      questions: questions..randomize(),
      variants: variants..randomize(),
    );
  }

  int _needTake({required int wordsUsed}) {
    return min(pairsPerQuiz, quizSize.preferredSize - wordsUsed);
  }
}
