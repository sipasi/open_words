import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:open_words/core/data/entities/folder/folder.dart';
import 'package:open_words/core/data/entities/id.dart';
import 'package:open_words/core/data/entities/word/word_group.dart';
import 'package:open_words/core/data/repository/explorer_repository.dart';
import 'package:open_words/core/data/repository/folder_repository.dart';
import 'package:open_words/core/services/logger/app_logger.dart';

part 'explorer_event.dart';
part 'explorer_state.dart';

class ExplorerBloc extends Bloc<ExplorerEvent, ExplorerState> {
  final logger = GetIt.I.get<AppLogger>();

  final ExplorerRepository explorerRepository;
  final FolderRepository folderRepository;

  ExplorerBloc({
    required this.explorerRepository,
    required this.folderRepository,
  }) : super(ExplorerState.initial()) {
    on<ExplorerStarted>((event, emit) async {
      emit(state.copyWith(loadStatus: ExplorerLoadStatus.loading));

      final data = await explorerRepository.allByFolder(const Id.empty());

      emit(
        state.copyWith(
          exploredFolder: () => null,
          folders: data.folders,
          groups: data.groups,
          loadStatus: ExplorerLoadStatus.loaded,
        ),
      );
    });
    on<ExplorerNavigateRequested>((event, emit) async {
      emit(state.copyWith(loadStatus: ExplorerLoadStatus.loading));

      final data = await explorerRepository.allByFolder(event.folder.id);

      emit(
        state.copyWith(
          exploredFolder: () => event.folder,
          folders: data.folders,
          groups: data.groups,
          loadStatus: ExplorerLoadStatus.loaded,
        ),
      );
    });
    on<ExplorerNavigateBackRequested>((event, emit) async {
      emit(state.copyWith(loadStatus: ExplorerLoadStatus.loading));

      final exploredBefore = state.exploredFolder;

      if (exploredBefore == null) {
        logger.e(
          '[ExplorerBloc] on ExplorerNavigateBackRequested - cant navigate back',
        );

        return;
      }

      final data = await explorerRepository.allByFolder(
        exploredBefore.parentId,
      );

      final exploredNow = await folderRepository.oneById(
        exploredBefore.parentId,
      );

      emit(
        state.copyWith(
          exploredFolder: () => exploredNow,
          folders: data.folders,
          groups: data.groups,
          loadStatus: ExplorerLoadStatus.loaded,
        ),
      );
    });
    on<ExplorerRefreshRequested>((event, emit) async {
      emit(state.copyWith(loadStatus: ExplorerLoadStatus.loading));

      final data = await explorerRepository.allByFolder(state.exploredId);

      emit(
        state.copyWith(
          exploredFolder: () => state.exploredFolder,
          folders: data.folders,
          groups: data.groups,
          loadStatus: ExplorerLoadStatus.loaded,
        ),
      );
    });
  }
}
