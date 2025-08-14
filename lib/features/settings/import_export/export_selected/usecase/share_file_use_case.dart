import 'package:open_words/core/data/entities/word/word_group.dart';
import 'package:open_words/core/data/repository/word_repository.dart';
import 'package:open_words/core/services/file/share/file_share_service.dart';
import 'package:open_words/features/settings/import_export/export_selected/bloc/export_selected_bloc.dart';
import 'package:open_words/features/settings/import_export/export_selected/logic/word_group_formatter_factory.dart';
import 'package:open_words/features/settings/import_export/models/word_export.dart';
import 'package:open_words/features/settings/import_export/models/word_group_export.dart';

final class ShareFileUseCase {
  final FileShareService shareFileService;
  final WordRepository wordRepository;

  ShareFileUseCase({
    required this.shareFileService,
    required this.wordRepository,
  });

  Future invoke(ExportSelectedState state) async {
    final groups = await _prepareList(state.selected);

    final data = WordGroupFormatterFactory.format(
      state.exportExtension,
      groups,
    );

    await shareFileService.shareFile(
      name: state.fileNameOrDefault,
      extension: state.exportExtension.extension,
      data: data,
    );
  }

  Future<List<WordGroupExport>> _prepareList(List<WordGroup> selected) {
    return List.generate(selected.length, (index) async {
      final item = selected[index];

      final words = await wordRepository.allByGroup(item.id);

      return WordGroupExport.from(item, words.map(WordExport.from).toList());
    }).wait;
  }
}
