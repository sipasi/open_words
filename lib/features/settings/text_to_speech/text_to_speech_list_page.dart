import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:open_words/features/settings/text_to_speech/cubit/text_to_speech_list_cubit.dart';
import 'package:open_words/features/settings/text_to_speech/widgets/example_text.dart';
import 'package:open_words/features/settings/text_to_speech/widgets/voice_tile.dart';
import 'package:open_words/shared/layout/constrained_align.dart';

class TextToSpeechListPage extends StatelessWidget {
  const TextToSpeechListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TextToSpeechListCubit(
        languageInfoService: GetIt.I.get(),
        textToSpeech: GetIt.I.get(),
        voiceStorage: GetIt.I.get(),
      )..init(),
      child: TextToSpeechListView(),
    );
  }
}

class TextToSpeechListView extends StatelessWidget {
  const TextToSpeechListView({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<TextToSpeechListCubit>();

    final languages = bloc.state.languages;
    final selectedVoice = bloc.state.selectedVoice;

    return Scaffold(
      appBar: AppBar(),
      body: ConstrainedAlign(
        child: ListView.builder(
          itemCount: languages.length + 1,
          itemBuilder: (context, index) {
            if (index == 0) {
              return ExampleText();
            }

            final languageIndex = index - 1;

            final language = languages[languageIndex];

            final voice = selectedVoice[language];

            return VoiceTile(language: language, voice: voice);
          },
        ),
      ),
    );
  }
}
