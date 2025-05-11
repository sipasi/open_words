import 'package:flutter/material.dart';
import 'package:open_words/features/settings/widgets/settings_tile_button.dart';
import 'package:open_words/features/settings_import_export/export_selection/export_selection_page.dart';
import 'package:open_words/shared/navigation/material_navigator.dart';

class ExportTile extends StatelessWidget {
  const ExportTile({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsTileButton(
      title: 'Export',
      icon: Icons.file_upload_outlined,
      onTap: () => context.push((context) => ExportSelectionPage()),
    );
  }
}
