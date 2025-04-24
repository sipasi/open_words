import 'package:flutter/material.dart';
import 'package:open_words/core/data/entities/id.dart';
import 'package:open_words/core/data/entities/metadata/definition.dart';
import 'package:open_words/core/data/entities/metadata/meaning.dart';
import 'package:open_words/core/data/entities/metadata/phonetic.dart';
import 'package:open_words/core/data/entities/metadata/word_metadata.dart';
import 'package:open_words/features/word_metadata/detail/word_metadata_view.dart';
import 'package:skeletonizer/skeletonizer.dart';

class WordMetadataLoadingView extends StatelessWidget {
  final WordMetadata? fake;

  const WordMetadataLoadingView({super.key, this.fake});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(child: WordMetadataView(metadata: fake ?? _create()));
  }

  WordMetadata _create() {
    return const WordMetadata(
      id: Id.empty(),
      word: 'advice',
      origin:
          'from Old French avis, based on Latin ad ‘to’ + visum, past participle of videre ‘to see’. The original sense was ‘way of looking at something, judgement’, hence later ‘an opinion given’',
      phonetic: '/ədˈvaɪs/',
      phonetics: [
        Phonetic(
          id: Id.empty(),
          metadataId: Id.empty(),
          value: '/ədˈvaɪs/',
          audio: '',
        ),
        Phonetic(
          id: Id.empty(),
          metadataId: Id.empty(),
          value: '/ædˈvaɪs/',
          audio:
              'https://api.dictionaryapi.dev/media/pronunciations/en/advice-us.mp3',
        ),
      ],
      meanings: [
        Meaning(
          id: Id.empty(),
          metadataId: Id.empty(),
          partOfSpeech: 'noun',
          definitions: [
            Definition(
              id: Id.empty(),
              meaningId: Id.empty(),
              value: 'An opinion offered in an effort to be helpful.',
              example:
                  'She was offered various piece of advice on what to do with her new-found wealth.',
            ),

            Definition(
              id: Id.empty(),
              meaningId: Id.empty(),
              value: 'Deliberate consideration; knowledge.',
              example: '',
            ),
            Definition(
              id: Id.empty(),
              meaningId: Id.empty(),
              value:
                  '(commonly in plural) Information or news given; intelligence',
              example: 'late advices from France',
            ),
          ],
          synonyms: ['admonition', 'counsel', 'exhortation'],
          antonyms: [],
        ),
        Meaning(
          id: Id.empty(),
          metadataId: Id.empty(),
          partOfSpeech: 'adv',
          definitions: [
            Definition(
              id: Id.empty(),
              meaningId: Id.empty(),
              value:
                  'In language about financial transactions executed by formal documents, an advisory document.',
              example:
                  'An advice of an incoming settlement payment order may be given to an off-line receiving bank.',
            ),
            Definition(
              id: Id.empty(),
              meaningId: Id.empty(),
              value:
                  'In commercial language, information communicated by letter; used chiefly in reference to drafts or bills of exchange',
              example: 'a letter of advice',
            ),
            Definition(
              id: Id.empty(),
              meaningId: Id.empty(),
              value:
                  'A communication providing information, such as how an uncertain area of law might apply to possible future actions',
              example:
                  'An advice issued by a Monitoring Committee could be applicable in a Dutch court',
            ),
          ],
          synonyms: [
            'information',
            'notice',
            'recommendation',
            'rede',
            'suggestion',
            'tip',
          ],
          antonyms: ['antonyms', 'antonyms', 'antonyms', 'antonyms'],
        ),
      ],
    );
  }
}
