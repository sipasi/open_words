import 'package:flutter/material.dart';
import 'package:open_words/features/settings/list/widgets/settings_tile_group.dart';
import 'package:open_words/features/settings/list/widgets/tiles/add_preinstalled_tile.dart';
import 'package:open_words/features/settings/list/widgets/tiles/ai_provider_tile.dart';
import 'package:open_words/features/settings/list/widgets/tiles/database_info_open_tile.dart';
import 'package:open_words/features/settings/list/widgets/tiles/delete_all_tile.dart';
import 'package:open_words/features/settings/list/widgets/tiles/export_tile.dart';
import 'package:open_words/features/settings/list/widgets/tiles/import_tile.dart';
import 'package:open_words/features/settings/list/widgets/tiles/text_to_speech_tile.dart';
import 'package:open_words/features/settings/list/widgets/tiles/thank_you_tile.dart';
import 'package:open_words/features/settings/list/widgets/tiles/theme_color_tile.dart';
import 'package:open_words/features/settings/list/widgets/tiles/theme_mode_tile.dart';
import 'package:open_words/features/settings/list/widgets/tiles/translator_tile.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(bottom: 40),
      children: [
        ThankYouTile(),

        SettingsTileGroup.many(children: [ThemeModeTile(), ThemeColorTile()]),

        SettingsTileGroup.single(child: AiProviderTile()),
        SettingsTileGroup.single(child: TranslatorTile()),
        SettingsTileGroup.single(child: TextToSpeechTile()),

        SettingsTileGroup.many(children: [ImportTile(), ExportTile()]),

        SettingsTileGroup.many(
          children: [AddPreinstalledTile(), DeleteAllTile()],
        ),

        SettingsTileGroup.single(child: DatabaseInfoOpenTile()),
      ],
    );
  }
}
