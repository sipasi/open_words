import 'package:open_words/core/data/entities/word/word_group.dart';
import 'package:open_words/core/data/repository/word_repository.dart';
import 'package:open_words/core/services/file/local_save/local_file_service.dart';
import 'package:open_words/features/settings_import_export/export_selected/bloc/export_selected_bloc.dart';
import 'package:open_words/features/settings_import_export/export_selected/logic/word_group_formatter_factory.dart';
import 'package:open_words/features/settings_import_export/export_selected/models/word_export.dart';
import 'package:open_words/features/settings_import_export/export_selected/models/word_group_export.dart';

final class LoadFileToDeviceUseCase {
  final LocalFileService localFileService;
  final WordRepository wordRepository;

  LoadFileToDeviceUseCase({
    required this.localFileService,
    required this.wordRepository,
  });

  Future invoke(ExportSelectedState state) async {
    final groups = await _prepareList(state.selected);

    final data = WordGroupFormatterFactory.format(
      state.exportExtension,
      groups,
    );

    final file = await localFileService.createIn(
      place: (directory) => directory.downloadsOrDocuments,
      name: state.fileNameOrDefault,
      extension: state.exportExtension.extension,
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
