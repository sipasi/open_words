import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:open_words/core/services/file/picker/file_picker_service.dart';
import 'package:open_words/core/services/language/language_info_service.dart';
import 'package:open_words/core/services/logger/app_logger.dart';
import 'package:open_words/features/settings/import_export/models/language_info_resolver.dart';
import 'package:open_words/features/settings/import_export/models/word_group_export.dart';
import 'package:open_words/shared/builders/value_builder_extension.dart';

part 'import_picker_state.dart';

class ImportPickerCubit extends Cubit<ImportPickerState> {
  final AppLogger logger;

  final FilePickerService filePicker;

  final LanguageInfoResolver languageResolver;

  ImportPickerCubit({
    required this.filePicker,
    required LanguageInfoService languageInfoService,
  }) : logger = GetIt.I.get<AppLogger>(),
       languageResolver = LanguageInfoResolver(service: languageInfoService),
       super(ImportPickerState.initial());

  Future started() async {
    emit(state.copyWith(filePickingStatus: FilePickingStatus.picking));

    final picked = await filePicker.pickFilesAsBytes(
      title: 'Select json files to import',
      type: .custom,
      allowedExtensions: ["json"],
    );

    if (picked.isEmpty) {
      emit(state.copyWith(filePickingStatus: FilePickingStatus.pickedNothing));
      return;
    }

    final groups = _read(picked);

    emit(
      state.copyWith(
        groups: groups,
        filePickingStatus: groups.valueBuilderOr(
          when: (groups) => groups.isNotEmpty,
          builder: (value) => FilePickingStatus.picked,
          or: () => FilePickingStatus.pickedNothing,
        ),
      ),
    );
  }

  List<WordGroupExport> _read(List<Uint8List> files) {
    final filesString = files.map((file) => utf8.decode(file));

    try {
      return filesString.map(_parceExports).expand((e) => e).toList();
    } catch (e) {
      logger.e(e.toString(), error: e);
    }

    return const [];
  }

  List<WordGroupExport> _parceExports(String text) {
    final decoded = json.decode(text);

    if (decoded case List<dynamic> list) {
      return list
          .map(
            (e) => WordGroupExport.fromMap(
              languageResolver: languageResolver,
              map: e,
            ),
          )
          .toList();
    }

    return [
      WordGroupExport.fromMap(languageResolver: languageResolver, map: decoded),
    ];
  }

  void toggle(WordGroupExport group) {
    final selected = Set<WordGroupExport>.from(state.selected);

    if (selected.add(group) == false) {
      selected.remove(group);
    }

    emit(state.copyWith(selected: selected));
  }

  void toggleAll() {
    final selected = state.selected.toSet();

    selected.clear();

    if (!state.selectedAll) {
      selected.addAll(state.groups);
    }

    emit(state.copyWith(selected: selected));
  }
}
