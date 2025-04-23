import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_words/core/data/entities/word/word.dart';
import 'package:open_words/core/data/entities/word/word_group.dart';
import 'package:open_words/core/data/repository/word_group_repository.dart';
import 'package:open_words/core/data/repository/word_repository.dart';

part 'word_group_detail_state.dart';

class WordGroupDetailCubit extends Cubit<WordGroupDetailState> {
  final WordRepository wordRepository;
  final WordGroupRepository groupRepository;

  WordGroupDetailCubit({
    required WordGroup group,
    required this.wordRepository,
    required this.groupRepository,
  }) : super(WordGroupDetailState.initial(group));

  Future init() async {
    emit(state.copyWith(loadingState: LoadingState.loading));

    final id = state.group.id;

    if (id.isEmpty) {
      return;
    }

    final words = await wordRepository.allByGroup(id);

    emit(state.copyWith(words: words, loadingState: LoadingState.loading));
  }
}
