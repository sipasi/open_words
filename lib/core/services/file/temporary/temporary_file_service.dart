import 'package:open_words/core/services/file/local_save/local_file.dart';
import 'package:open_words/core/services/file/local_save/local_file_service.dart';
import 'package:open_words/core/services/path/app_directory_extension.dart';
import 'package:uuid/uuid.dart';

/// A service for creating and managing temporary files.
///
/// Temporary files are created for scoped usage and automatically cleaned up when no longer needed.
sealed class TemporaryFileService {
  const TemporaryFileService();

  /// Creates a temporary file and runs [onCreated] with it in a scoped context.
  ///
  /// The temporary file has the provided [name] and [extension]. If [name] is null,
  /// a unique name be generated.
  ///
  /// The [onCreated] callback receives the [LocalFile] instance and is responsible
  /// for performing all necessary operations within the scope.
  ///
  /// Implementation delete the file automatically after the callback completes.
  Future withTemporaryFile({
    String? name,
    required String extension,
    required Future Function(LocalFile temporary) onCreated,
  });
}

final class TemporaryFileServiceImpl extends TemporaryFileService {
  static const _folderName = 'Temporary files';

  final LocalFileService localFileService;

  final Uuid uuid;

  TemporaryFileServiceImpl({required this.localFileService})
    : uuid = const Uuid();

  @override
  Future withTemporaryFile({
    String? name,
    required String extension,
    required Future Function(LocalFile temporary) onCreated,
  }) async {
    final localFile = await localFileService.createIn(
      place: (directory) {
        return directory.temporary.withSubPath(
          label: _folderName,
          parts: [_folderName],
        );
      },
      name: _name(name),
      extension: extension,
    );

    await onCreated(localFile);

    await localFile.delete();
  }

  String _name(String? name) {
    return name ?? uuid.v4();
  }
}
