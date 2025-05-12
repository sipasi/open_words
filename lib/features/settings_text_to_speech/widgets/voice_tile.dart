import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_words/core/data/entities/language_info.dart';
import 'package:open_words/core/result/result.dart';
import 'package:open_words/core/services/text_to_speech/text_to_speech_voice.dart';
import 'package:open_words/features/settings_text_to_speech/cubit/text_to_speech_list_cubit.dart';
import 'package:open_words/features/settings_text_to_speech/widgets/text_to_speech_voice_dialog.dart';

class VoiceTile extends StatelessWidget {
  const VoiceTile({super.key, required this.language, required this.voice});

  final LanguageInfo language;
  final TextToSpeechVoice? voice;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(language.name),
      subtitle: Text(voice?.description() ?? 'Not set, will be used default'),
      trailing: Text(language.native),
      onTap: () => _onTap(context),
    );
  }

  Future _onTap(BuildContext context) async {
    final bloc = context.read<TextToSpeechListCubit>();

    final result = await TextToSpeechVoiceDialog.show(
      context: context,
      voices: bloc.textToSpeech.voicesByLanguage(language),
      current: bloc.voiceStorage.getByLanguage(language),
    );

    if (result is! SuccessResult<TextToSpeechVoice>) {
      return;
    }

    result.onSuccess((value) {
      bloc.rememberVoice(language, value);
    });
  }
}
