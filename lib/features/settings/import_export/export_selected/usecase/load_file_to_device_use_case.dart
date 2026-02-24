import 'package:flutter/foundation.dart';
import 'package:open_words/core/data/repository/word_metadata_repository.dart';
import 'package:open_words/core/data/repository/word_repository.dart';
import 'package:open_words/core/services/file/local_save/local_file_service.dart';
import 'package:open_words/core/services/file/web_file/web_file_service.dart';
import 'package:open_words/features/settings/import_export/export_selected/bloc/export_selected_bloc.dart';
import 'package:open_words/features/settings/import_export/export_selected/logic/word_group_formatter_factory.dart';
import 'package:open_words/features/settings/import_export/export_selected/usecase/prepare_export_use_case.dart';
import 'package:open_words/features/settings/import_export/export_selected/usecase/properties_to_options_use_case.dart';

final class LoadFileToDeviceUseCase {
  final LocalFileService localFileService;
  final WebFileService webFileService;
  final WordRepository wordRepository;
  final WordMetadataRepository metadataRepository;

  LoadFileToDeviceUseCase({
    required this.localFileService,
    required this.webFileService,
    required this.wordRepository,
    required this.metadataRepository,
  });

  Future invoke(ExportSelectedState state) async {
    final groups = await PrepareExportUseCase.invoke(
      selected: state.selected,
      wordRepository: wordRepository,
      metadataRepository: metadataRepository,
    );

    final data = await WordGroupFormatterFactory.format(
      state.exportExtension,
      groups,
      PropertiesToOptionsUseCase.invoke(state),
    );

    final name = state.fileNameOrDefault;
    final extension = state.exportExtension.extension;

    if (kIsWeb) {
      return webFileService.download(
        name: name,
        extension: extension,
        bytes: data,
      );
    }

    final file = await localFileService.createIn(
      place: (directory) => directory.downloadsOrDocuments,
      name: name,
      extension: extension,
    );

    await file.writeBytes(data);
  }
}
