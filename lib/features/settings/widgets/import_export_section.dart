import 'package:flutter/material.dart';
import 'package:open_words/features/settings_import_export/export_selection/export_selection_page.dart';
import 'package:open_words/features/settings_import_export/import/import_page.dart';
import 'package:open_words/shared/navigation/material_navigator.dart';

class ImportExportSection extends StatelessWidget {
  const ImportExportSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Icon(Icons.file_download_outlined),
          title: OutlinedButton(
            onPressed: () => context.push((context) => ImportPage()),
            child: Text('Import'),
          ),
        ),
        ListTile(
          leading: Icon(Icons.file_upload_outlined),
          title: OutlinedButton(
            onPressed: () => context.push((context) => ExportSelectionPage()),
            child: Text('Export'),
          ),
          onTap: () {},
        ),
      ],
    );
  }
}
