import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_words/features/settings/import_export/export_selected/export_selected_page.dart';
import 'package:open_words/features/settings/import_export/export_selection/bloc/export_selection_cubit.dart';
import 'package:open_words/shared/navigation/material_navigator.dart';

class ExportSelectionFab extends StatelessWidget {
  const ExportSelectionFab({super.key});

  @override
  Widget build(BuildContext context) {
    final isEmpty = context.select(
      (ExportSelectionCubit value) => value.state.selected.isEmpty,
    );

    if (isEmpty) {
      return const SizedBox.shrink();
    }

    return FloatingActionButton.extended(
      icon: Icon(Icons.chevron_right_outlined),
      label: Text('Next'),
      onPressed: () {
        final selected = context.read<ExportSelectionCubit>().state.selected;

        context.push(
          (context) => ExportSelectedPage(selected: selected.toList()),
        );
      },
    );
  }
}
