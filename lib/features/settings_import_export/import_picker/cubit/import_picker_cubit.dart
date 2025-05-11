import 'dart:convert';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:open_words/core/services/file/picker/file_picker_service.dart';
import 'package:open_words/core/services/logger/app_logger.dart';
import 'package:open_words/features/settings_import_export/export_selected/models/word_group_export.dart';
import 'package:open_words/shared/builders/value_builder_extension.dart';

part 'import_picker_state.dart';

class ImportPickerCubit extends Cubit<ImportPickerState> {
  final AppLogger logger;

  final FilePickerService filePicker;

  ImportPickerCubit({required this.filePicker})
    : logger = GetIt.I.get<AppLogger>(),
      super(ImportPickerState.initial());

  Future started() async {
    emit(state.copyWith(filePickingStatus: FilePickingStatus.picking));

    final picked = await filePicker.pickFiles(
      title: 'Select json files to import',
    );

    if (picked.isEmpty) {
      emit(state.copyWith(filePickingStatus: FilePickingStatus.pickedNothing));
      return;
    }

    final groups = await _read(picked);

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

  Future<List<WordGroupExport>> _read(List<File> files) async {
    final filesString = await Future.wait(
      files.map((file) => file.readAsString()),
    );

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
      return list.map((e) => WordGroupExport.fromMap(e)).toList();
    }

    return [WordGroupExport.fromMap(decoded)];
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
