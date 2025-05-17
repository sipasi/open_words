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
import 'package:open_words/shared/modal/loading_dialog.dart';
import 'package:open_words/shared/navigation/material_navigator.dart';

class ExportSelectedPage extends StatelessWidget {
  final List<WordGroup> selected;

  const ExportSelectedPage({super.key, required this.selected});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) => ExportSelectedBloc(
            themeStorage: GetIt.I.get(),
            shareFileService: GetIt.I.get(),
            localFileService: GetIt.I.get(),
            wordRepository: GetIt.I.get(),
          )..add(ExportSelectedStarded(selected)),
      child: BlocListener<ExportSelectedBloc, ExportSelectedState>(
        listenWhen: _listenWhen,
        listener: _listener,
        child: ExportSelectedView(),
      ),
    );
  }

  bool _listenWhen(ExportSelectedState previous, ExportSelectedState current) {
    return previous.executingStatus != current.executingStatus;
  }

  void _listener(BuildContext context, ExportSelectedState state) async {
    if (state.executingStatus.isExecuting) {
      LoadingDialog.show(context: context, title: "Exporting");
    }
    if (state.executingStatus.isFinished) {
      await Future.delayed(Duration(milliseconds: 500));

      if (context.mounted) context.pop(times: 3);
    }
  }
}

class ExportSelectedView extends StatelessWidget {
  const ExportSelectedView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
