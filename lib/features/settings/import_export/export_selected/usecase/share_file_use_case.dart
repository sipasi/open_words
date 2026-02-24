import 'package:open_words/core/data/repository/word_metadata_repository.dart';
import 'package:open_words/core/data/repository/word_repository.dart';
import 'package:open_words/core/services/file/share/file_share_service.dart';
import 'package:open_words/features/settings/import_export/export_selected/bloc/export_selected_bloc.dart';
import 'package:open_words/features/settings/import_export/export_selected/logic/word_group_formatter_factory.dart';
import 'package:open_words/features/settings/import_export/export_selected/usecase/prepare_export_use_case.dart';
import 'package:open_words/features/settings/import_export/export_selected/usecase/properties_to_options_use_case.dart';

final class ShareFileUseCase {
  final FileShareService shareFileService;
  final WordRepository wordRepository;
  final WordMetadataRepository metadataRepository;

  ShareFileUseCase({
    required this.shareFileService,
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

    await shareFileService.shareFile(
      name: state.fileNameOrDefault,
      extension: state.exportExtension.extension,
      data: data,
    );
  }
}
