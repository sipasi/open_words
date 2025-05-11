import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_words/features/settings_import_export/import_picker/cubit/import_picker_cubit.dart';
import 'package:open_words/shared/selectable/grid_view/selectable_grid_view.dart';

class ImportPickerSelectableView extends StatelessWidget {
  const ImportPickerSelectableView({super.key});

  @override
  Widget build(BuildContext context) {
    final items = context.select(
      (ImportPickerCubit value) => value.state.groups,
    );
    final selected = context.select(
      (ImportPickerCubit value) => value.state.selected,
    );

    return SelectableGridView(
      items: items,
      selected: selected,
      title: (item) => item.name,
      onToggle: context.read<ImportPickerCubit>().toggle,
    );
  }
}
