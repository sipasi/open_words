import 'package:flutter/material.dart';
import 'package:open_words/features/settings/_main_screen/widgets/settings_tile_button.dart';
import 'package:open_words/features/settings/import_export/import_picker/import_picker_page.dart';
import 'package:open_words/shared/navigation/material_navigator.dart';

class ImportTile extends StatelessWidget {
  const ImportTile({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsTileButton(
      title: 'Import',
      icon: Icons.file_download_outlined,
      onTap: () => context.push((context) => ImportPickerPage()),
    );
  }
}
