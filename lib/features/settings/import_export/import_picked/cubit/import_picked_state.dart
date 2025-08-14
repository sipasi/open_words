part of 'import_picked_cubit.dart';

enum ImportStatus {
  none,
  importing,
  imported;

  bool get isImporting => this == importing;
  bool get isImported => this == imported;
}

class ImportPickedState {
  final FolderPath folderPath;

  final String subfolder;

  final ImportStatus importStatus;

  ImportPickedState({
    required this.importStatus,
    required this.subfolder,
    required this.folderPath,
  });
  ImportPickedState.initial()
    : importStatus = ImportStatus.none,
      subfolder = '',
      folderPath = const FolderPath.root();

  ImportPickedState copyWith({
    FolderPath? folderPath,
    String? subfolder,
    ImportStatus? importStatus,
  }) {
    return ImportPickedState(
      folderPath: folderPath ?? this.folderPath,
      subfolder: subfolder ?? this.subfolder,
      importStatus: importStatus ?? this.importStatus,
    );
  }
}
