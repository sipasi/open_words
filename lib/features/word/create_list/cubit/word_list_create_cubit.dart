import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_words/core/data/draft/word_draft.dart';
import 'package:open_words/core/data/entities/word/word_group.dart';
import 'package:open_words/core/data/repository/word_group_repository.dart';
import 'package:open_words/core/data/repository/word_repository.dart';
import 'package:open_words/core/services/ai_bridge/ai_bridge_provider.dart';
import 'package:open_words/core/services/language/translation/translator_service.dart';
import 'package:open_words/core/services/language/translation/translator_template.dart';
import 'package:open_words/core/services/language/translation/translator_url_builder.dart';

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
  final TranslatorService translatorService;
  final AiBridgeProvider aiBridgeProvider;

  Stream<WordListUiEvent> get uiEvents => _uiEvent.stream;
  Stream<WordDraft> get draftRemovedEvent => _draftRemovedEvent.stream;

  WordListCreateCubit({
    required this.group,
    required this.groupRepository,
    required this.wordRepository,
    required this.translatorService,
    required this.aiBridgeProvider,
  }) : super(WordListCreateState.initial());

  Future init() async {
    final isConnected = await aiBridgeProvider.isConnected;

    if (isClosed) {
      return;
    }

    emit(state.copyWith(aiAvailable: isConnected));
  }

  void setOrigin(String value) {
    emit(state.copyWith(originDraft: value));
  }

  void setTranslation(String value) {
    emit(state.copyWith(translationDraft: value));
  }

  Future launchTranslator(TranslatorTemplate option) async {
    if (state.originDraft.isEmpty) {
      return;
    }

    final request = TranslationRequest(
      source: group.origin,
      target: group.translation,
      word: state.originDraft,
    );

    await translatorService.launch(option, request);
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
