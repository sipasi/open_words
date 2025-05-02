part of 'explorer_bloc.dart';

enum ExplorerLoadStatus {
  loading,
  loaded;

  bool get isLoading => this == loading;
  bool get isLoaded => this == loaded;
}

class ExplorerState {
  final Folder? exploredFolder;

  final List<Folder> folders;
  final List<WordGroup> groups;

  final ExplorerLoadStatus loadStatus;

  Id get exploredId => exploredFolder?.id ?? const Id.empty();
  String get exploredName => exploredFolder?.name ?? 'Home';

  bool get isEmpty => folders.isEmpty && groups.isEmpty;

  int get count => folders.length + groups.length;

  bool get isRootFolder => exploredFolder == null;

  const ExplorerState({
    required this.exploredFolder,
    required this.folders,
    required this.groups,
    required this.loadStatus,
  });
  const ExplorerState.initial()
    : exploredFolder = null,
      folders = const [],
      groups = const [],
      loadStatus = ExplorerLoadStatus.loading;

  ExplorerState copyWith({
    Folder? Function()? exploredFolder,
    List<Folder>? folders,
    List<WordGroup>? groups,
    ExplorerLoadStatus? loadStatus,
  }) {
    if (exploredFolder == null) {
      return ExplorerState(
        exploredFolder: this.exploredFolder,
        folders: folders ?? this.folders,
        groups: groups ?? this.groups,
        loadStatus: loadStatus ?? this.loadStatus,
      );
    }

    return ExplorerState(
      exploredFolder: exploredFolder.call(),
      folders: folders ?? this.folders,
      groups: groups ?? this.groups,
      loadStatus: loadStatus ?? this.loadStatus,
    );
  }
}
