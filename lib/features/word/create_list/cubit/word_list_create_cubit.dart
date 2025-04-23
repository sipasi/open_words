import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_words/core/data/draft/word_draft.dart';
import 'package:open_words/core/data/entities/word/word_group.dart';
import 'package:open_words/core/data/repository/word_group_repository.dart';
import 'package:open_words/core/data/repository/word_repository.dart';

part 'word_list_create_state.dart';

enum WordListUiEvent {
  clearAllInput,
  // add more UI-only signals later like showSnackbar, focusField, etc.
}

class WordListCreateCubit extends Cubit<WordListCreateState> {
  final _uiEvent = StreamController<WordListUiEvent>.broadcast();
  final _draftRemovedEvent = StreamController<WordDraft>.broadcast();

  final WordGroup group;

  final WordGroupRepository groupRepository;
  final WordRepository wordRepository;

  Stream<WordListUiEvent> get uiEvents => _uiEvent.stream;
  Stream<WordDraft> get draftRemovedEvent => _draftRemovedEvent.stream;

  WordListCreateCubit({
    required this.group,
    required this.groupRepository,
    required this.wordRepository,
  }) : super(WordListCreateState.initial());

  void setOrigin(String value) {
    emit(state.copyWith(originDraft: value));
  }

  void setTranslation(String value) {
    emit(state.copyWith(translationDraft: value));
  }

  void addDraft() {
    final (origin, translation) = (state.originDraft, state.translationDraft);

    if (origin.isEmpty || translation.isEmpty) {
      return;
    }

    final draft = WordDraft(origin: origin, translation: translation);

    emit(
      state.copyWith(
        drafts: state.drafts.toList()..add(draft),
        originDraft: '',
        translationDraft: '',
      ),
    );

    _uiEvent.add(WordListUiEvent.clearAllInput);
  }

  void removeDraft(int index) {
    final draft = state.drafts.removeAt(index);

    emit(
      state.copyWith(
        drafts: state.drafts.toList()..remove(draft),
        originDraft: draft.origin,
        translationDraft: draft.translation,
      ),
    );

    _draftRemovedEvent.add(draft);
  }

  Future save() {
    return wordRepository.createAll(groupId: group.id, drafts: state.drafts);
  }

  @override
  Future<void> close() async {
    await _uiEvent.close();
    await _draftRemovedEvent.close();
    await super.close();
  }
}
