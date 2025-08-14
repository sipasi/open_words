import 'package:flutter/material.dart';
import 'package:open_words/features/settings/list/widgets/settings_tile_button.dart';
import 'package:open_words/features/settings/text_to_speech/text_to_speech_list_page.dart';
import 'package:open_words/shared/navigation/material_navigator.dart';

class TextToSpeechTile extends StatelessWidget {
  const TextToSpeechTile({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsTileButton(
      title: 'Text to speech',
      icon: Icons.text_fields,
      onTap: () => context.push((context) => TextToSpeechListPage()),
    );
  }
}
