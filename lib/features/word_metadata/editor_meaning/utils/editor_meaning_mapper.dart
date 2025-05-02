import 'package:open_words/core/data/entities/metadata/meaning.dart';
import 'package:open_words/features/word_metadata/editor_meaning/cubit/editor_meaning_cubit.dart';

sealed class EditorMeaningMapper {
  static Meaning fromCubit(EditorMeaningCubit cubit) {
    final state = cubit.state;

    return Meaning(
      id: cubit.meaningId,
      metadataId: cubit.metadataId,
      partOfSpeech: state.partOfSpeech,
      definitions: state.definitions,
      synonyms: _parseCommaSeparatedList(state.synonyms),
      antonyms: _parseCommaSeparatedList(state.antonyms),
    );
  }

  static List<String> _parseCommaSeparatedList(String text) {
    if (text.isEmpty) {
      return const [];
    }

    return text
        .split(',')
        .map((e) => e.trim())
        .where((element) => element.isNotEmpty)
        .toList();
  }
}
