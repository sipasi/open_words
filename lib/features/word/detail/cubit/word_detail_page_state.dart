part of 'word_detail_page_cubit.dart';

class WordDetailPageState {
  final WordGroup group;

  final String origin;
  final String translation;

  WordDetailPageState({
    required this.group,
    required this.origin,
    required this.translation,
  });
  WordDetailPageState.initial({required this.group, required Word word})
    : origin = word.origin,
      translation = word.translation;

  WordDetailPageState copyWith({String? origin, String? translation}) {
    return WordDetailPageState(
      group: group,
      origin: origin ?? this.origin,
      translation: translation ?? this.translation,
    );
  }
}
