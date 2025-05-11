import 'package:flutter/material.dart';
import 'package:open_words/features/database/database_info_page.dart';
import 'package:open_words/features/settings/widgets/settings_tile_button.dart';
import 'package:open_words/shared/navigation/material_navigator.dart';

class DatabaseInfoOpenTile extends StatelessWidget {
  const DatabaseInfoOpenTile({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsTileButton(
      title: 'Open database info',
      icon: Icons.storage_outlined,
      onTap: () => context.push((context) => DatabaseInfoPage()),
    );
  }
}
