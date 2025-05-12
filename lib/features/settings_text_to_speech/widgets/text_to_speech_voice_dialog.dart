import 'package:flutter/material.dart';
import 'package:open_words/core/services/text_to_speech/text_to_speech_voice.dart';
import 'package:open_words/shared/modal/list_view_modal.dart';
import 'package:open_words/shared/navigation/material_navigator.dart';

class TextToSpeechVoiceDialog {
  static Future show({
    required BuildContext context,
    required List<TextToSpeechVoice> voices,
    required TextToSpeechVoice? current,
  }) {
    return ListViewModal.dialog(
      context: context,
      length: voices.length,
      builder: (index) {
        final voice = voices[index];

        bool isSelected = voice == current;

        return ListTile(
          title: Text(voice.name),
          subtitle: Text(voice.description()),
          selected: isSelected,
          onTap: () => context.popSuccess(voice),
        );
      },
    );
  }
}
