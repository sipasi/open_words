import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_words/features/settings_import_export/import_picked/import_picked_page.dart';
import 'package:open_words/features/settings_import_export/import_picker/cubit/import_picker_cubit.dart';
import 'package:open_words/shared/navigation/material_navigator.dart';

class ImportPickerFab extends StatelessWidget {
  const ImportPickerFab({super.key});

  @override
  Widget build(BuildContext context) {
    final pickingStatus = context.select(
      (ImportPickerCubit value) => value.state.filePickingStatus,
    );
    final selected = context.select(
      (ImportPickerCubit value) => value.state.selected,
    );

    if (pickingStatus.isPicking) {
      return FloatingActionButton(
        child: const SizedBox(
          height: 24,
          width: 24,
          child: CircularProgressIndicator(),
        ),
        onPressed: () {},
      );
    }

    if (pickingStatus.isNothing) {
      return FloatingActionButton.extended(
        icon: Icon(Icons.file_present),
        label: Text('Pick files'),
        onPressed: () => context.read<ImportPickerCubit>().started(),
      );
    }

    if (selected.isEmpty) {
      return FloatingActionButton.extended(
        icon: Icon(Icons.chevron_right_outlined),
        label: Text('Select at least one'),
        onPressed: () {},
      );
    }

    return FloatingActionButton.extended(
      icon: Icon(Icons.chevron_right_outlined),
      label: Text('Next'),
      onPressed: () {
        context.push((context) => ImportPickedPage(groups: selected.toList()));
      },
    );
  }
}
