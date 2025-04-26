import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_words/features/settings_import_export/export_selected/bloc/export_selected_bloc.dart';
import 'package:open_words/features/settings_import_export/export_selected/models/export_destination.dart';

class ExportSelectedFab extends StatelessWidget {
  const ExportSelectedFab({super.key});

  @override
  Widget build(BuildContext context) {
    final destination = context.select(
      (ExportSelectedBloc value) => value.state.exportDestination,
    );

    return FloatingActionButton.extended(
      onPressed: () {},
      icon: switch (destination) {
        ExportDestination.onDevice => Icon(Icons.file_download_outlined),
        _ => Icon(Icons.share_outlined),
      },
      label: Text(destination.name),
    );
  }
}
