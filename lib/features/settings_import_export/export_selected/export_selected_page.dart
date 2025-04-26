import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:open_words/core/data/entities/word/word_group.dart';
import 'package:open_words/features/settings_import_export/export_selected/bloc/export_selected_bloc.dart';
import 'package:open_words/features/settings_import_export/export_selected/widgets/export_destination_selector.dart';
import 'package:open_words/features/settings_import_export/export_selected/widgets/export_extension_selector.dart';
import 'package:open_words/features/settings_import_export/export_selected/widgets/export_selected_fab.dart';
import 'package:open_words/features/settings_import_export/export_selected/widgets/export_selected_name_input.dart';
import 'package:open_words/features/settings_import_export/export_selected/widgets/extension_properies/extension_properies.dart';

class ExportSelectedPage extends StatelessWidget {
  final List<WordGroup> selected;

  const ExportSelectedPage({super.key, required this.selected});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              ExportSelectedBloc(themeStorage: GetIt.I.get())
                ..add(ExportSelectedStarded(selected)),
      child: ExportSelectedView(),
    );
  }
}

class ExportSelectedView extends StatelessWidget {
  const ExportSelectedView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: []),
      floatingActionButton: ExportSelectedFab(),
      body: ListView(
        children: [
          ExportSelectedNameInput(),
          ExportDestinationSelector(),
          Divider(),
          ExportExtensionSelector(),
          ExtensionProperies(),
        ],
      ),
    );
  }
}
