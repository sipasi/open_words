import 'package:flutter/material.dart';
import 'package:open_words/features/settings/_main_screen/widgets/settings_tile_button.dart';
import 'package:open_words/features/settings/add_preinstalled/add_preinsalled_page.dart';
import 'package:open_words/shared/navigation/material_navigator.dart';

class AddPreinstalledTile extends StatelessWidget {
  const AddPreinstalledTile({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsTileButton(
      title: 'Add Preinstalled',
      icon: Icons.install_desktop,
      onTap: () => context.push((context) => AddPreinsalledPage()),
    );
  }
}
