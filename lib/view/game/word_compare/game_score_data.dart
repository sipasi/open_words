import 'package:open_words/data/metadata/word_metadata.dart';
import 'package:open_words/data/word/word.dart';

class GameScoreData {
  final List<Word> words;
  final Map<Word, WordMetadata> metadatas;

  GameScoreData({required this.words, required this.metadatas});
}
