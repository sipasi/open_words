import 'package:open_words/core/data/entities/entity.dart';
import 'package:open_words/core/data/entities/metadata/meaning.dart';
import 'package:open_words/core/data/entities/metadata/phonetic.dart';

class WordMetadata extends Entity {
  final String word;

  final String origin;

  final String phonetic;

  final List<Phonetic> phonetics;

  final List<Meaning> meanings;

  WordMetadata({
    required super.id,
    required this.word,
    required this.origin,
    required this.phonetic,
    required this.phonetics,
    required this.meanings,
  });
}
