part of 'explorer_entity_editor_cubit.dart';

enum CreateEntityType { none, wordGroup, folder }

enum EditorType { none, create, edit }

final class ExplorerEntityEditorState {
  final String name;

  final LanguageInfo origin;
  final LanguageInfo translation;

  final CreateEntityType createEntityType;

  bool get folderSelected => createEntityType == CreateEntityType.folder;
  bool get groupSelected => createEntityType == CreateEntityType.wordGroup;

  bool get canSave => name.trim().isNotEmpty;
  bool get canNotSave => !canSave;

  ExplorerEntityEditorState({
    required this.name,
    required this.origin,
    required this.translation,
    required this.createEntityType,
  });
  ExplorerEntityEditorState.initial()
    : name = '',
      origin = const LanguageInfo.empty(),
      translation = const LanguageInfo.empty(),
      createEntityType = CreateEntityType.none;

  ExplorerEntityEditorState copyWith({
    String? name,
    LanguageInfo? origin,
    LanguageInfo? translation,
    CreateEntityType? createEntityType,
  }) {
    return ExplorerEntityEditorState(
      name: name ?? this.name,
      origin: origin ?? this.origin,
      translation: translation ?? this.translation,
      createEntityType: createEntityType ?? this.createEntityType,
    );
  }
}
