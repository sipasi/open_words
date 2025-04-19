import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_words/core/data/entities/id.dart';
import 'package:open_words/core/data/entities/language_info.dart';
import 'package:open_words/core/data/entities/word/word.dart';
import 'package:open_words/core/data/repository/word_group_repository.dart';
import 'package:open_words/core/data/repository/word_repository.dart';

part 'word_group_detail_state.dart';

class WordGroupDetailCubit extends Cubit<WordGroupDetailState> {
  final Id id;
  final WordRepository wordRepository;
  final WordGroupRepository groupRepository;

  WordGroupDetailCubit({
    required this.id,
    required this.wordRepository,
    required this.groupRepository,
  }) : super(WordGroupDetailState.initial());

  Future init() async {
    emit(state.copyWith(id: id, loadingState: LoadingState.loading));

    final group = await groupRepository.byId(id);

    if (group == null) {
      return;
    }

    emit(
      state.copyWith(
        id: id,
        folderId: group.folderId,
        name: group.name,
        origin: group.origin,
        translation: group.translation,
        loadingState: LoadingState.loading,
      ),
    );

    final words = await wordRepository.allByGroup(group.id);

    emit(state.copyWith(words: words, loadingState: LoadingState.loaded));
  }
}
