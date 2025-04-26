import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_words/core/data/entities/word/word_group.dart';
import 'package:open_words/core/services/theme/theme_storage.dart';
import 'package:open_words/features/settings_import_export/export_selected/models/export_destination.dart';
import 'package:open_words/features/settings_import_export/export_selected/models/export_extension.dart';
import 'package:open_words/features/settings_import_export/export_selected/models/pdf_extension_properties.dart';
import 'package:open_words/shared/theme/color_seed.dart';

part 'export_selected_event.dart';
part 'export_selected_state.dart';

class ExportSelectedBloc
    extends Bloc<ExportSelectedEvent, ExportSelectedState> {
  final ThemeStorage themeStorage;

  ExportSelectedBloc({required this.themeStorage})
    : super(ExportSelectedState.initial()) {
    on<ExportSelectedStarded>((event, emit) {
      final selected = event.selected;

      emit(
        state.copyWith(
          selected: selected,
          fileDefaultName: selected.length == 1 ? selected[0].name : 'Groups',
          pdfProperties: state.pdfProperties.copyWith(
            darkBackground:
                PlatformDispatcher.instance.platformBrightness ==
                Brightness.dark,
            colorScheme: themeStorage.get().seed,
          ),
        ),
      );
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
  }
}
