import 'package:flutter/foundation.dart';
import 'package:open_words/core/data/entities/word/word_group.dart';
import 'package:open_words/core/data/repository/word_repository.dart';
import 'package:open_words/core/services/file/local_save/local_file_service.dart';
import 'package:open_words/core/services/file/web_file/web_file_service.dart';
import 'package:open_words/features/settings/import_export/export_selected/bloc/export_selected_bloc.dart';
import 'package:open_words/features/settings/import_export/export_selected/logic/word_group_formatter_factory.dart';
import 'package:open_words/features/settings/import_export/models/word_export.dart';
import 'package:open_words/features/settings/import_export/models/word_group_export.dart';

final class LoadFileToDeviceUseCase {
  final LocalFileService localFileService;
  final WebFileService webFileService;
  final WordRepository wordRepository;

  LoadFileToDeviceUseCase({
    required this.localFileService,
    required this.webFileService,
    required this.wordRepository,
  });

  Future invoke(ExportSelectedState state) async {
    final groups = await _prepareList(state.selected);

    final data = WordGroupFormatterFactory.format(
      state.exportExtension,
      groups,
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

  Future<List<WordGroupExport>> _prepareList(List<WordGroup> selected) {
    return List.generate(selected.length, (index) async {
      final item = selected[index];

      final words = await wordRepository.allByGroup(item.id);

      return WordGroupExport.from(item, words.map(WordExport.from).toList());
    }).wait;
  }
}
