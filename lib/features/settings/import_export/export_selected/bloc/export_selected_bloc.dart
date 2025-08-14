import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_words/core/data/entities/word/word_group.dart';
import 'package:open_words/core/data/repository/word_repository.dart';
import 'package:open_words/core/services/file/local_save/local_file_service.dart';
import 'package:open_words/core/services/file/share/file_share_service.dart';
import 'package:open_words/core/services/theme/theme_storage.dart';
import 'package:open_words/features/settings/import_export/export_selected/models/export_destination.dart';
import 'package:open_words/features/settings/import_export/export_selected/models/export_executing_status.dart';
import 'package:open_words/features/settings/import_export/export_selected/models/export_extension.dart';
import 'package:open_words/features/settings/import_export/export_selected/models/pdf_extension_properties.dart';
import 'package:open_words/features/settings/import_export/export_selected/usecase/load_file_to_device_use_case.dart';
import 'package:open_words/features/settings/import_export/export_selected/usecase/share_file_use_case.dart';
import 'package:open_words/shared/theme/color_seed.dart';

part 'export_selected_event.dart';
part 'export_selected_state.dart';

class ExportSelectedBloc
    extends Bloc<ExportSelectedEvent, ExportSelectedState> {
  final ThemeStorage themeStorage;
  final FileShareService shareFileService;
  final LocalFileService localFileService;
  final WordRepository wordRepository;

  ExportSelectedBloc({
    required this.themeStorage,
    required this.shareFileService,
    required this.localFileService,
    required this.wordRepository,
  }) : super(ExportSelectedState.initial()) {
    on<ExportSelectedStarded>((event, emit) {
      final selected = event.selected;

      emit(
        state.copyWith(
          selected: selected,
          pdfProperties: state.pdfProperties.copyWith(
            darkBackground:
                PlatformDispatcher.instance.platformBrightness ==
                Brightness.dark,
            colorScheme: themeStorage.get().seed,
          ),
        ),
      );
    });
    on<ExportSelectedFileNameChanged>((event, emit) {
      emit(state.copyWith(fileName: event.value));
    });
    on<ExportSelectedDestinationChanged>((event, emit) {
      emit(state.copyWith(exportDestination: event.value));
    });
    on<ExportSelectedExtensionChanged>((event, emit) {
      emit(state.copyWith(exportExtension: event.value));
    });
    on<ExportSelectedPdfChanged>((event, emit) {
      final pdfProperties = state.pdfProperties.copyWith(
        printing: event.printing,
        colorScheme: event.colorScheme,
        darkBackground: event.darkBackground,
      );

      emit(state.copyWith(pdfProperties: pdfProperties));
    });

    on<ExportSelectedShareRequested>((event, emit) async {
      emit(state.copyWith(executingStatus: ExportExecutingStatus.executing));

      await ShareFileUseCase(
        shareFileService: shareFileService,
        wordRepository: wordRepository,
      ).invoke(state);

      emit(state.copyWith(executingStatus: ExportExecutingStatus.finished));
    });
    on<ExportSelectedDownloadRequested>((event, emit) async {
      emit(state.copyWith(executingStatus: ExportExecutingStatus.executing));

      await LoadFileToDeviceUseCase(
        localFileService: localFileService,
        wordRepository: wordRepository,
      ).invoke(state);

      emit(state.copyWith(executingStatus: ExportExecutingStatus.finished));
    });
  }
}
