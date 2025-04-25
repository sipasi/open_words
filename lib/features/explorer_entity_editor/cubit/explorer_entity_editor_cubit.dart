import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_words/core/data/entities/language_info.dart';
import 'package:open_words/core/services/language/language_info_service.dart';
import 'package:open_words/features/explorer_entity_editor/models/explorer_entity_union.dart';

part 'explorer_entity_editor_state.dart';

class ExplorerEntityEditorCubit extends Cubit<ExplorerEntityEditorState> {
  final LanguageInfoService languageService;

  final ExplorerEntityUnion? entityUnion;

  EditorType get editorType =>
      entityUnion == null ? EditorType.create : EditorType.edit;

  ExplorerEntityEditorCubit(this.languageService, this.entityUnion)
    : super(ExplorerEntityEditorState.initial());

  void init() {
    emit(
      state.copyWith(
        
        name: entityUnion?.getName() ?? '',
        origin: entityUnion?.getOrigin() ?? languageService.english,
        translation: entityUnion?.getTranslation() ?? languageService.ukrainian,
        createEntityType:
            entityUnion?.getCreateEntityType() ?? CreateEntityType.wordGroup,
      ),
    );
  }

  void setName(String value) {
    emit(state.copyWith(name: value));
  }

  void setOrigin(LanguageInfo value) {
    emit(state.copyWith(origin: value));
  }

  void setTranslation(LanguageInfo value) {
    emit(state.copyWith(translation: value));
  }

  void setFolderView() {
    emit(state.copyWith(createEntityType: CreateEntityType.folder));
  }

  void setGroupView() {
    emit(state.copyWith(createEntityType: CreateEntityType.wordGroup));
  }
}
