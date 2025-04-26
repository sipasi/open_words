import 'package:flutter/material.dart';
import 'package:open_words/features/settings/widgets/add_preinstalled_tile.dart';
import 'package:open_words/features/settings/widgets/database_info_open_tile.dart';
import 'package:open_words/features/settings/widgets/import_export_section.dart';
import 'package:open_words/features/settings/widgets/settings_screen.dart';
import 'package:open_words/features/settings/widgets/thank_you_tile.dart';
import 'package:open_words/features/settings/widgets/theme_color_tile.dart';
import 'package:open_words/features/settings/widgets/theme_mode_tile.dart';
import 'package:open_words/features/settings/widgets/translator_tile.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(top: 10.0),
      children: [
        ThankYouTile(),
        const Divider(),
        ThemeModeTile(),
        ThemeColorTile(),
        const Divider(),
        TranslatorTile(),
        const Divider(),
        ImportExportSection(),
        const Divider(),
        AddPreinstalledTile(),
        DeleteAllTile(),
        const Divider(),
        DatabaseInfoOpenTile(),
      ],
    );
  }
}
