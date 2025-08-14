import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_words/features/settings/import_export/import_picked/cubit/import_picked_cubit.dart';
import 'package:open_words/shared/input_fields/text_edit_field.dart';

class CreateSubFolderTile extends StatelessWidget {
  const CreateSubFolderTile({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ImportPickedCubit>();

    return ListTile(
      title: TextEditField(
        border: InputBorder.none,
        label: 'Subfolder',
        onChanged: bloc.setSubfolder,
      ),
      subtitle: Text('If empty import in selected folder'),
    );
  }
}
