import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_words/core/data/entities/id.dart';
import 'package:open_words/core/data/entities/metadata/definition.dart';
import 'package:open_words/core/data/entities/metadata/meaning.dart';

part 'editor_meaning_state.dart';

class EditorMeaningCubit extends Cubit<EditorMeaningState> {
  final Id metadataId;
  final Meaning? initial;

  Id get meaningId => initial?.id ?? const Id.empty();

  bool get isCreate => initial == null;
  bool get isEdit => initial != null;

  EditorMeaningCubit({required this.metadataId, this.initial})
    : super(EditorMeaningState.initial()) {
    init();
  }

  void init() {
    if (initial == null) {
      return;
    }

    emit(
      EditorMeaningState(
        partOfSpeech: initial!.partOfSpeech,
        definitions: initial!.definitions.toList(),
        definitionsRemoved: const [],
        synonyms: initial!.synonyms.join(', '),
        antonyms: initial!.antonyms.join(', '),
      ),
    );
  }

  void tryCreate() {}

  void tryUpdate() {}

  void tryDelete() {}

  void addDefinition(Definition value) {
    final definitions = state.definitions.toList()..add(value);

    emit(state.copyWith(definitions: definitions));
  }

  void removeDefinition(Definition value) {
    final definitions = state.definitions.toList()..remove(value);
    final definitionsRemoved = state.definitionsRemoved.toList()..add(value);

    emit(
      state.copyWith(
        definitions: definitions,
        definitionsRemoved: definitionsRemoved,
      ),
    );
  }

  void updateDefinition({
    required Definition source,
    required Definition value,
  }) {
    final definitions = state.definitions.toList();

    final index = definitions.indexOf(source);

    definitions[index] = value;

    emit(state.copyWith(definitions: definitions));
  }

  void setSynonyms(String value) {
    emit(state.copyWith(synonym: value));
  }

  void setAntonyms(String value) {
    emit(state.copyWith(antonym: value));
  }

  void setPartOfSpeech(String value) {
    emit(state.copyWith(partOfSpeech: value));
  }
}
