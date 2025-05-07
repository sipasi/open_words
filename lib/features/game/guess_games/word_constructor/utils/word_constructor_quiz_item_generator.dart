import 'package:open_words/core/collection/list_random_extension.dart';
import 'package:open_words/core/data/entities/word/word.dart';
import 'package:open_words/features/game/guess_games/word_constructor/models/word_constructor_quiz_item.dart';
import 'package:open_words/features/game/guess_games/word_constructor/models/word_part.dart';
import 'package:open_words/features/game/shared/quiz/quiz_exports.dart';

final class WordConstructorQuizItemGenerator {
  final List<Word> words;
  final QuizQuestionSide questionSide;
  final QuizSize quizSize;

  WordConstructorQuizItemGenerator({
    required this.words,
    required this.questionSide,
    required this.quizSize,
  });

  List<WordConstructorQuizItem> generate() {
    final shuffledWords = words.toList()..randomize();

    return List.generate(quizSize.preferredSize, (index) {
      final word = shuffledWords[index];

      final variant = questionSide.variant(word);

      final answerParts = _spitWord(variant);

      return WordConstructorQuizItem(
        question: questionSide.question(word),
        correctAnswer: variant,
        answerParts: answerParts..randomize(),
      );
    });
  }

  List<WordPart> _spitWord(String word) {
    final parts = <WordPart>[];

    for (int i = 0; i < word.length; i += 2) {
      int end = (i + 2 < word.length) ? i + 2 : word.length;

      parts.add(WordPart(id: i, text: word.substring(i, end)));
    }

    return parts;
  }
}
