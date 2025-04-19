import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_words/core/data/entities/folder/folder.dart';
import 'package:open_words/core/data/entities/id.dart';
import 'package:open_words/core/data/entities/word/word_group.dart';
import 'package:open_words/core/data/repository/folder_repository.dart';
import 'package:open_words/core/data/repository/word_group_repository.dart';

part 'explorer_event.dart';
part 'explorer_state.dart';

class ExplorerBloc extends Bloc<ExplorerEvent, ExplorerState> {
  final FolderRepository folderRepository;
  final WordGroupRepository groupRepository;

  ExplorerBloc({required this.folderRepository, required this.groupRepository})
    : super(ExplorerState.initial()) {
    on<ExplorerLoadRequested>((event, emit) async {
      final id = event.folderId;

      emit(
        state.copyWith(
          exploredId: event.folderId,
          exploredFolder: id.isEmpty ? null : await folderRepository.byId(id),
          folders: await folderRepository.allByParent(id),
          groups: await groupRepository.allByFolder(id),
        ),
      );
    });
    on<ExplorerRefreshRequested>((event, emit) async {
      final exploredId = state.exploredId;

      emit(
        state.copyWith(
          exploredId: exploredId,
          exploredFolder: state.exploredFolder,
          folders: await folderRepository.allByParent(exploredId),
          groups: await groupRepository.allByFolder(exploredId),
        ),
      );
    });
  }
}
