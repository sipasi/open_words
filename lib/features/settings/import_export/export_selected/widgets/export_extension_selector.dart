import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_words/features/settings/import_export/export_selected/bloc/export_selected_bloc.dart';
import 'package:open_words/features/settings/import_export/export_selected/widgets/export_extension_modal.dart';

class ExportExtensionSelector extends StatelessWidget {
  const ExportExtensionSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final extension = context.select(
      (ExportSelectedBloc value) => value.state.exportExtension,
    );

    return ListTile(
      leading: Icon(Icons.extension_outlined),
      title: Text('Extension'),
      subtitle: Text(extension.extension),
      onTap: () async {
        final value = await ExportExtensionModal.dialog(
          context: context,
          current: extension,
        );

        if (value == null || !context.mounted) {
          return;
        }

        context.read<ExportSelectedBloc>().add(
          ExportSelectedExtensionChanged(value),
        );
      },
    );
  }
}
