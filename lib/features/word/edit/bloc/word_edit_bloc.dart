import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_words/core/data/draft/metadata/word_metadata_draft.dart';
import 'package:open_words/core/data/entities/id.dart';
import 'package:open_words/core/data/entities/metadata/definition.dart';
import 'package:open_words/core/data/entities/metadata/meaning.dart';
import 'package:open_words/core/data/entities/metadata/phonetic.dart';
import 'package:open_words/core/data/entities/metadata/word_metadata.dart';
import 'package:open_words/core/data/repository/word_metadata_repository.dart';

part 'word_edit_event.dart';
part 'word_edit_state.dart';

class WordEditBloc extends Bloc<WordEditEvent, WordEditState> {
  final WordMetadataRepository metadataRepository;

  final Id wordId;
  final Id metadataId;

  final String initialOrigin;
  final String initialTranslation;
  final WordMetadata initialMetadata;

  bool get isCreate => initialMetadata.id.isEmpty;

  WordEditBloc({
    required this.metadataRepository,
    required this.wordId,
    required this.metadataId,
    required this.initialOrigin,
    required this.initialTranslation,
    required this.initialMetadata,
  }) : super(WordEditState.initial()) {
    on<WordEditStarted>((event, emit) {
      emit(
        state.copyWith(
          translation: event.translation,
          etymology: event.metadata.etymology,
          phonetics: event.metadata.phonetics.toList(),
          meanings: event.metadata.meanings.map((e) => e.deepCopy()).toList(),
        ),
      );
    });
    on<WordEditSaveRequested>((event, emit) async {
      if (state.saveStatus != WordEditSaveStatus.none) {
        return;
      }

      emit(state.copyWith(saveStatus: WordEditSaveStatus.saving));

      await metadataRepository.delete(initialMetadata.id);

      final metadata = WordMetadata(
        id: const Id.empty(),
        word: initialOrigin,
        etymology: state.etymology,
        phonetics: state.phonetics,
        meanings: state.meanings,
      );

      await metadataRepository.create(WordMetadataDraft.fromMetadata(metadata));

      emit(state.copyWith(saveStatus: WordEditSaveStatus.saved));
    });

    on<WordEditTranslationChanged>((event, emit) {
      emit(state.copyWith(translation: event.value));
    });
    on<WordEditEtymologyChanged>((event, emit) {
      emit(state.copyWith(etymology: event.value));
    });

    on<WordEditPhoneticCreateRequested>((event, emit) {
      emit(
        state.copyWith(
          phonetics: [
            ...state.phonetics,
            Phonetic(
              id: const Id.empty(),
              metadataId: metadataId,
              value: event.value,
              audio: event.audio,
            ),
          ],
        ),
      );
    });
    on<WordEditPhoneticDeleteRequested>((event, emit) {
      final phonetics = state.phonetics.toList()..remove(event.value);

      final phoneticsRemoved =
          event.value.id.isEmpty
              ? state.phoneticsRemoved
              : [...state.phoneticsRemoved, event.value];

      emit(
        state.copyWith(
          phonetics: phonetics,
          phoneticsRemoved: phoneticsRemoved,
        ),
      );
    });
    on<WordEditPhoneticUpdateRequested>((event, emit) {
      final toUpdate = event.toUpdate;

      if (event.value == toUpdate.value && event.audio == toUpdate.audio) {
        return;
      }

      final phonetics = state.phonetics.toList();

      final index = phonetics.indexOf(toUpdate);

      phonetics[index] = toUpdate.copyWith(
        value: event.value,
        audio: event.audio,
      );

      emit(state.copyWith(phonetics: phonetics));
    });

    on<WordEditMeaningCreateRequested>((event, emit) {
      emit(
        state.copyWith(
          meanings: [
            ...state.meanings,
            Meaning(
              id: const Id.empty(),
              metadataId: metadataId,
              partOfSpeech: event.partOfSpeech,
              definitions: event.definitions,
              synonyms: event.synonyms,
              antonyms: event.antonyms,
            ),
          ],
        ),
      );
    });
    on<WordEditMeaningDeleteRequested>((event, emit) {
      final meanings = state.meanings.toList()..remove(event.value);

      final meaningsRemoved =
          event.value.id.isEmpty
              ? state.meaningsRemoved
              : [...state.meaningsRemoved, event.value];

      emit(
        state.copyWith(meanings: meanings, meaningsRemoved: meaningsRemoved),
      );
    });
    on<WordEditMeaningUpdateRequested>((event, emit) {
      final toUpdate = event.toUpdate;

      final meanings = state.meanings.toList();

      final index = meanings.indexOf(toUpdate);

      meanings[index] = toUpdate.copyWith(
        partOfSpeech: event.partOfSpeech,
        definitions: event.definitions,
        synonyms: event.synonyms,
        antonyms: event.antonyms,
      );

      emit(state.copyWith(meanings: meanings));
    });
  }
}
