import 'package:open_words/core/data/entities/folder/folder.dart';
import 'package:open_words/core/data/entities/language_info.dart';
import 'package:open_words/core/data/entities/word/word_group.dart';
import 'package:open_words/features/explorer_entity_editor/cubit/explorer_entity_editor_cubit.dart';

class ExplorerEntityUnion {
  final Folder? folder;
  final WordGroup? group;

  ExplorerEntityUnion.folder(Folder folder) : folder = folder, group = null;
  ExplorerEntityUnion.group(WordGroup group) : folder = null, group = group;

  String? getName() => folder?.name ?? group?.name;
  LanguageInfo? getOrigin() => group?.origin;
  LanguageInfo? getTranslation() => group?.translation;
  CreateEntityType? getCreateEntityType() =>
      group != null ? CreateEntityType.wordGroup : CreateEntityType.folder;
}
