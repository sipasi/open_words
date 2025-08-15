import 'package:flutter/material.dart';
import 'package:open_words/features/settings/_main_screen/widgets/settings_tile_group.dart';
import 'package:open_words/features/settings/_main_screen/widgets/tiles/add_preinstalled_tile.dart';
import 'package:open_words/features/settings/_main_screen/widgets/tiles/ai_provider_tile.dart';
import 'package:open_words/features/settings/_main_screen/widgets/tiles/database_info_open_tile.dart';
import 'package:open_words/features/settings/_main_screen/widgets/tiles/delete_all_tile.dart';
import 'package:open_words/features/settings/_main_screen/widgets/tiles/export_tile.dart';
import 'package:open_words/features/settings/_main_screen/widgets/tiles/import_tile.dart';
import 'package:open_words/features/settings/_main_screen/widgets/tiles/text_to_speech_tile.dart';
import 'package:open_words/features/settings/_main_screen/widgets/tiles/thank_you_tile.dart';
import 'package:open_words/features/settings/_main_screen/widgets/tiles/theme_color_tile.dart';
import 'package:open_words/features/settings/_main_screen/widgets/tiles/theme_mode_tile.dart';
import 'package:open_words/features/settings/_main_screen/widgets/tiles/translator_tile.dart';
import 'package:open_words/shared/layout/constrained_align.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ConstrainedAlign(
      child: ListView(
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
      ),
    );
  }
}
