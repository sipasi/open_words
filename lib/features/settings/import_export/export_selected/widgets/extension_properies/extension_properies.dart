import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_words/features/settings/import_export/export_selected/bloc/export_selected_bloc.dart';
import 'package:open_words/features/settings/import_export/export_selected/models/export_extension.dart';
import 'package:open_words/features/settings/import_export/export_selected/widgets/extension_properies/pdf_properies.dart';
import 'package:open_words/features/settings/import_export/export_selected/widgets/extension_properies/without_properties.dart';

class ExtensionProperies extends StatelessWidget {
  const ExtensionProperies({super.key});

  @override
  Widget build(BuildContext context) {
    final extension = context.select(
      (ExportSelectedBloc value) => value.state.exportExtension,
    );

    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: switch (extension) {
        ExportExtension.pdf => PdfProperies(),
        _ => WithoutProperties(),
      },
    );
  }
}
