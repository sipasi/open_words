import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_words/features/settings/import_export/export_selection/bloc/export_selection_cubit.dart';
import 'package:open_words/shared/selectable/grid_view/selectable_grid_view.dart';

class ExportSelectionListView extends StatelessWidget {
  const ExportSelectionListView({super.key});

  @override
  Widget build(BuildContext context) {
    final items = context.select(
      (ExportSelectionCubit value) => value.state.groups,
    );
    final selected = context.select(
      (ExportSelectionCubit value) => value.state.selected,
    );

    return SelectableGridView(
      items: items,
      selected: selected,
      title: (item) => item.name,
      onToggle: context.read<ExportSelectionCubit>().toggle,
    );
  }
}
