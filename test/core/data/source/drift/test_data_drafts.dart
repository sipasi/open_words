import 'package:open_words/core/data/draft/metadata/definition_draft.dart';
import 'package:open_words/core/data/draft/metadata/meaning_draft.dart';
import 'package:open_words/core/data/draft/metadata/phonetic_draft.dart';
import 'package:open_words/core/data/draft/metadata/word_metadata_draft.dart';

/// Centralized test fixtures for WordMetadata tests
///
/// Usage:
/// - MetadataTestData.base()
/// - MetadataTestData.updatedFieldsOnly()
/// - MetadataTestData.updatedFull()
///
/// All methods are deterministic and idempotent.
sealed class MetadataTestData {
  // ---------- BASE ----------
  static WordMetadataDraft base({
    String word = 'test',
    String etymology = 'old etymology',
  }) {
    return WordMetadataDraft(
      word: word,
      etymology: etymology,
      phonetics: [
        PhoneticDraft(
          value: '/test/',
          audio: 'audio-1.mp3',
        ),
      ],
      meanings: [
        MeaningDraft(
          partOfSpeech: 'noun',
          definitions: [
            DefinitionDraft(
              value: 'first definition',
              example: 'example 1',
            ),
          ],
          synonyms: ['exam'],
          antonyms: ['certainty'],
        ),
      ],
    );
  }

  // ---------- UPDATED FIELDS ONLY (delta) ----------

  /// Represents *only new or changed data*
  /// Used to test merge / upsert logic
  static WordMetadataDraft updatedFieldsOnly({
    String word = 'test',
    String etymology = 'new etymology',
  }) {
    return WordMetadataDraft(
      word: word,
      etymology: etymology,
      phonetics: [
        PhoneticDraft(
          value: '/test/',
          audio: 'audio-2.mp3',
        ),
      ],
      meanings: [
        MeaningDraft(
          partOfSpeech: 'noun',
          definitions: [
            DefinitionDraft(
              value: 'zero definition',
              example: 'example 0',
            ),
            DefinitionDraft(
              value: 'second definition',
              example: 'example 2',
            ),
            DefinitionDraft(
              value: 'third definition',
              example: 'example 3',
            ),
          ],
          synonyms: ['best', 'trial'],
          antonyms: ['advice'],
        ),
        MeaningDraft(
          partOfSpeech: 'adv',
          definitions: [],
          synonyms: [],
          antonyms: [],
        ),
      ],
    );
  }

  // ---------- UPDATED FULL (expected final state) ----------

  /// Expected final result after:
  /// base() + updatedFieldsOnly()
  static WordMetadataDraft updatedFull({
    String word = 'test',
    String etymology = 'new etymology',
  }) {
    return WordMetadataDraft(
      word: word,
      etymology: etymology,
      phonetics: [
        PhoneticDraft(
          value: '/test/',
          audio: 'audio-1.mp3',
        ),
        PhoneticDraft(
          value: '/tɛst/',
          audio: 'audio-2.mp3',
        ),
      ],
      meanings: [
        MeaningDraft(
          partOfSpeech: 'noun',
          definitions: [
            DefinitionDraft(
              value: 'zero definition',
              example: 'example 0',
            ),
            DefinitionDraft(
              value: 'first definition',
              example: 'example 1',
            ),
            DefinitionDraft(
              value: 'second definition',
              example: 'example 2',
            ),
            DefinitionDraft(
              value: 'third definition',
              example: 'example 3',
            ),
          ],
          synonyms: ['best', 'exam', 'trial'],
          antonyms: ['advice', 'certainty'],
        ),
        MeaningDraft(
          partOfSpeech: 'adv',
          definitions: [],
          synonyms: [],
          antonyms: [],
        ),
      ],
    );
  }
}
