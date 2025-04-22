import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_words/core/data/entities/word/word.dart';
import 'package:open_words/core/data/entities/word/word_group.dart';

part 'word_detail_page_state.dart';

class WordDetailPageCubit extends Cubit<WordDetailPageState> {
  final WordGroup group;

  WordDetailPageCubit({required this.group, required Word word})
    : super(WordDetailPageState.initial(group: group, word: word));
}
