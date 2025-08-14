import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_words/features/settings/import_export/export_selection/bloc/export_selection_cubit.dart';

class ExportSelectionSelectAll extends StatelessWidget {
  const ExportSelectionSelectAll({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedAll = context.select(
      (ExportSelectionCubit value) => value.state.selectedAll,
    );

    return TextButton(
      onPressed: () => context.read<ExportSelectionCubit>().toggleAll(),
      child: selectedAll ? Icon(Icons.done_all_outlined) : Text('Select all'),
    );
  }
}
