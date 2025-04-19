part of 'explorer_bloc.dart';

class ExplorerState {
  final Id exploredId;
  final Folder? exploredFolder;

  final List<Folder> folders;
  final List<WordGroup> groups;

  String get exploredName => exploredFolder?.name ?? 'Home';

  bool get isEmpty => folders.isEmpty && groups.isEmpty;

  int get count => folders.length + groups.length;

  bool get isRootFolder => exploredFolder == null;

  const ExplorerState({
    required this.exploredId,
    required this.exploredFolder,
    required this.folders,
    required this.groups,
  });
  const ExplorerState.initial()
    : exploredId = const Id.empty(),
      exploredFolder = null,

      folders = const [],
      groups = const [];

  ExplorerState copyWith({
    required Id exploredId,
    required Folder? exploredFolder,
    List<Folder>? folders,
    List<WordGroup>? groups,
  }) {
    return ExplorerState(
      exploredId: exploredId,
      exploredFolder: exploredFolder,
      folders: folders ?? this.folders,
      groups: groups ?? this.groups,
    );
  }
}
