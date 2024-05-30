import 'package:open_words/data/metadata/definition.dart';
import 'package:open_words/data/metadata/meaning.dart';
import 'package:open_words/data/metadata/word_metadata.dart';

abstract class WordMetadataGenarator {
  static WordMetadata get() {
    return WordMetadata(
      word: 'word.origin',
      phonetics: List.empty(),
      meanings: [
        Meaning(
          partOfSpeech: 'partOfSpeech',
          definitions: [
            Definition(
              value: 'Cupidatat nostrud ut sint culpa aliquip sint excepteur consectetur.',
              example: 'Do magna sit cupidatat irure laborum deserunt cupidatat non laborum ullamco.',
            ),
            Definition(
              value: 'Amet enim exercitation non tempor nulla labore fugiat pariatur commodo.',
              example: 'Proident excepteur veniam velit tempor anim duis commodo cupidatat.',
            ),
            Definition(
              value: 'Culpa quis do cillum excepteur eiusmod commodo esse.',
              example: 'Laborum ex nostrud proident tempor proident ut sit et nisi magna laborum aliqua nisi.',
            ),
            Definition(
              value: 'Voluptate elit aliqua laborum ex occaecat in labore reprehenderit non.',
              example: 'Nisi ut cupidatat pariatur laborum duis nisi.',
            ),
            Definition(value: 'Amet consectetur duis quis minim commodo anim aliqua proident aliqua qui fugiat in sit.')
          ],
          synonyms: List.generate(10, (index) => 'synonym $index'),
          antonyms: List.generate(10, (index) => 'antonym $index'),
        ),
      ],
    );
  }
}
