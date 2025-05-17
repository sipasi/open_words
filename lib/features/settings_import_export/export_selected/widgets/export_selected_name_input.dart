import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_words/features/settings_import_export/export_selected/bloc/export_selected_bloc.dart';
import 'package:open_words/shared/input_fields/text_edit_field.dart';

class ExportSelectedNameInput extends StatelessWidget {
  const ExportSelectedNameInput({super.key});

  @override
  Widget build(BuildContext context) {
    final selected = context.select(
      (ExportSelectedBloc value) => value.state.selected,
    );

    return ListTile(
      title: TextEditField(
        border: OutlineInputBorder(),
        hint: selected.length == 1 ? selected[0].name : 'WordGroups',
        onChanged: (value) {
          context.read<ExportSelectedBloc>().add(
            ExportSelectedFileNameChanged(value),
          );
        },
      ),
    );
  }
}
