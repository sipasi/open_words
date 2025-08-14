import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:open_words/features/settings/import_export/import_picker/cubit/import_picker_cubit.dart';
import 'package:open_words/features/settings/import_export/import_picker/widgets/import_picker_fab.dart';
import 'package:open_words/features/settings/import_export/import_picker/widgets/import_picker_select_all.dart';
import 'package:open_words/features/settings/import_export/import_picker/widgets/import_picker_selectable_view.dart';
import 'package:open_words/shared/builders/value_builder_extension.dart';

class ImportPickerPage extends StatelessWidget {
  const ImportPickerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ImportPickerCubit(
        filePicker: GetIt.I.get(),
        languageInfoService: GetIt.I.get(),
      )..started(),
      child: ImportPickerView(),
    );
  }
}

class ImportPickerView extends StatelessWidget {
  const ImportPickerView({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.select((ImportPickerCubit value) => value.state);

    return Scaffold(
      appBar: state.filePickingStatus.valueBuilder(
        when: (value) => value.isPickedOrNothing,
        builder: (value) => AppBar(actions: [ImportPickerSelectAll()]),
      ),
      body: ImportPickerSelectableView(),
      floatingActionButton: ImportPickerFab(),
    );
  }
}
