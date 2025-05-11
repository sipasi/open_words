import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_words/features/settings_import_export/import_picker/cubit/import_picker_cubit.dart';

class ImportPickerSelectAll extends StatelessWidget {
  const ImportPickerSelectAll({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedAll = context.select(
      (ImportPickerCubit value) => value.state.selectedAll,
    );

    return TextButton(
      onPressed: context.read<ImportPickerCubit>().toggleAll,
      child: selectedAll ? Icon(Icons.done_all_outlined) : Text('Select all'),
    );
  }
}
