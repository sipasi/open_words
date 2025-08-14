import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:open_words/features/settings/import_export/export_selection/bloc/export_selection_cubit.dart';
import 'package:open_words/features/settings/import_export/export_selection/widgets/export_selection_fab.dart';
import 'package:open_words/features/settings/import_export/export_selection/widgets/export_selection_list_view.dart';
import 'package:open_words/features/settings/import_export/export_selection/widgets/export_selection_select_all.dart';

class ExportSelectionPage extends StatelessWidget {
  const ExportSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return ExportSelectionCubit(groupRepository: GetIt.I.get())..init();
      },
      child: ExportSelectionView(),
    );
  }
}

class ExportSelectionView extends StatelessWidget {
  const ExportSelectionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [ExportSelectionSelectAll()]),
      body: ExportSelectionListView(),
      floatingActionButton: ExportSelectionFab(),
    );
  }
}
