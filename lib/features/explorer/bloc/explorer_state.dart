part of 'explorer_bloc.dart';

class ExplorerState {
  final Folder? exploredFolder;

  final List<Folder> folders;
  final List<WordGroup> groups;

  Id get exploredId => exploredFolder?.id ?? const Id.empty();
  String get exploredName => exploredFolder?.name ?? 'Home';

  bool get isEmpty => folders.isEmpty && groups.isEmpty;

  int get count => folders.length + groups.length;

  bool get isRootFolder => exploredFolder == null;

  const ExplorerState({
    required this.exploredFolder,
    required this.folders,
    required this.groups,
  });
  const ExplorerState.initial()
    : exploredFolder = null,
      folders = const [],
      groups = const [];

  ExplorerState copyWith({
    required Folder? Function() exploredFolder,
    List<Folder>? folders,
    List<WordGroup>? groups,
  }) {
    return ExplorerState(
      exploredFolder: exploredFolder.call(),
      folders: folders ?? this.folders,
      groups: groups ?? this.groups,
    );
  }
}
