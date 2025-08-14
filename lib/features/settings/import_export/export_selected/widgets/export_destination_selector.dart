import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_words/features/settings/import_export/export_selected/bloc/export_selected_bloc.dart';
import 'package:open_words/features/settings/import_export/export_selected/models/export_destination.dart';

class ExportDestinationSelector extends StatelessWidget {
  const ExportDestinationSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final destination = context.select(
      (ExportSelectedBloc value) => value.state.exportDestination,
    );

    return ListTile(
      title: SegmentedButton(
        segments: [
          ButtonSegment(
            icon: Icon(Icons.share_outlined),
            label: Text(ExportDestination.share.name),
            value: ExportDestination.share,
          ),
          ButtonSegment(
            icon: Icon(Icons.devices_outlined),
            label: Text(ExportDestination.onDevice.name),
            value: ExportDestination.onDevice,
          ),
        ],
        selected: {destination},
        onSelectionChanged: (value) => context.read<ExportSelectedBloc>().add(
          ExportSelectedDestinationChanged(value.first),
        ),
      ),
    );
  }
}
