import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_words/core/data/draft/word_draft.dart';
import 'package:open_words/core/data/entities/folder/folder_path.dart';
import 'package:open_words/core/data/entities/id.dart';
import 'package:open_words/core/data/repository/folder_repository.dart';
import 'package:open_words/core/data/repository/word_group_repository.dart';
import 'package:open_words/core/data/repository/word_repository.dart';
import 'package:open_words/features/settings_import_export/export_selected/models/word_group_export.dart';

part 'import_picked_state.dart';

class ImportPickedCubit extends Cubit<ImportPickedState> {
  final List<WordGroupExport> groups;
  final FolderRepository folderRepository;
  final WordGroupRepository groupRepository;
  final WordRepository wordRepository;

  ImportPickedCubit({
    required this.groups,
    required this.folderRepository,
    required this.groupRepository,
    required this.wordRepository,
  }) : super(ImportPickedState.initial());

  void setPath(FolderPath path) {
    emit(state.copyWith(folderPath: path));
  }

  Future import() async {
    emit(state.copyWith(importStatus: ImportStatus.importing));

    var folderId = await _getFolderId();

    await _writeToDatabase(folderId);

    emit(state.copyWith(importStatus: ImportStatus.imported));
  }

  void setSubfolder(String value) {
    emit(state.copyWith(subfolder: value));
  }

  Future<Id> _getFolderId() async {
    if (state.subfolder.isEmpty) {
      return state.folderPath.folderId;
    }

    final folder = await folderRepository.create(
      parentId: state.folderPath.folderId,
      name: state.subfolder,
    );

    return folder.id;
  }

  Future _writeToDatabase(Id folderId) async {
    for (var item in groups) {
      final group = await groupRepository.create(
        folderId: folderId,
        name: item.name,
        origin: item.origin,
        translation: item.translation,
      );

      await wordRepository.createAll(
        groupId: group.id,
        drafts:
            item.words.map((e) {
              return WordDraft(origin: e.origin, translation: e.translation);
            }).toList(),
      );
    }
  }
}
