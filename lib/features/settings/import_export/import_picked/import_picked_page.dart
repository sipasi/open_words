import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:open_words/features/explorer/_main_screen/bloc/explorer_bloc.dart';
import 'package:open_words/features/settings/import_export/import_picked/cubit/import_picked_cubit.dart';
import 'package:open_words/features/settings/import_export/import_picked/widgets/create_sub_folder_tile.dart';
import 'package:open_words/features/settings/import_export/import_picked/widgets/select_folder_tile.dart';
import 'package:open_words/features/settings/import_export/models/word_group_export.dart';
import 'package:open_words/shared/layout/constrained_align.dart';
import 'package:open_words/shared/modal/loading_dialog.dart';
import 'package:open_words/shared/navigation/material_navigator.dart';

class ImportPickedPage extends StatelessWidget {
  final List<WordGroupExport> groups;

  const ImportPickedPage({super.key, required this.groups});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ImportPickedCubit(
        groups: groups,
        folderRepository: GetIt.I.get(),
        groupRepository: GetIt.I.get(),
        wordRepository: GetIt.I.get(),
        metadataRepository: GetIt.I.get(),
      ),
      child: BlocListener<ImportPickedCubit, ImportPickedState>(
        listener: _listener,
        child: ImportPickedView(),
      ),
    );
  }

  void _listener(BuildContext context, ImportPickedState state) async {
    if (state.importStatus.isImporting) {
      LoadingDialog.show(context: context, title: 'Importing');
    }

    if (state.importStatus.isImported) {
      context.read<ExplorerBloc>().add(ExplorerRefreshRequested());

      await Future.delayed(Duration(milliseconds: 500));

      if (context.mounted) context.pop(times: 3);
    }
  }
}

class ImportPickedView extends StatelessWidget {
  const ImportPickedView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ConstrainedAlign(
        child: ListView(children: [SelectFolderTile(), CreateSubFolderTile()]),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.file_download_outlined),
        label: Text('Import'),
        onPressed: context.read<ImportPickedCubit>().import,
      ),
    );
  }
}
