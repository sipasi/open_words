import 'package:open_words/features/game/guess_games/word_constructor/models/word_part.dart';

class WordPartConstructor {
  final List<WordPart> parts;

  final int correctCount;

  int get partCount => parts.length;

  String get constructedString => parts.map((e) => e.text).join();

  bool get constructed => partCount == correctCount;

  const WordPartConstructor(this.parts, this.correctCount);
  const WordPartConstructor.empty() : parts = const [], correctCount = 0;
  const WordPartConstructor.withCorrectCount(this.correctCount)
    : parts = const [];

  bool contains(WordPart part) {
    return parts.contains(part);
  }

  WordPartConstructor copyWithPart(WordPart part) {
    return copyWith(parts: [...parts, part]);
  }

  WordPartConstructor copyWithoutPart(WordPart part) {
    return copyWith(parts: List.from(parts)..remove(part));
  }

  WordPartConstructor copyWith({List<WordPart>? parts, int? correctCount}) {
    return WordPartConstructor(
      parts ?? this.parts,
      correctCount ?? this.correctCount,
    );
  }
}
