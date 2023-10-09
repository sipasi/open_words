import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:open_words/data/language_info.dart';
import 'package:open_words/data/metadata/word_metadata.dart';
import 'package:open_words/service/clipboard_service.dart';
import 'package:open_words/service/text_to_speech_service.dart';
import 'package:open_words/view/word/detail/metadata/meaning_view.dart';

class WordMetadataView extends StatelessWidget {
  final WordMetadata metadata;
  final LanguageInfo language;

  static final TextToSpeechService _textToSpeech = GetIt.I.get<TextToSpeechService>();
  static final ClipboardService _clipboard = GetIt.I.get<ClipboardService>();

  const WordMetadataView({
    super.key,
    required this.metadata,
    required this.language,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final headlineSmall = theme.textTheme.headlineSmall?.copyWith(
      fontWeight: FontWeight.bold,
    );

    final meanings = metadata.meanings;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Meanings', style: headlineSmall),
          const SizedBox(height: 20),
          ...List.generate(meanings.length, (index) {
            return MeaningView(
              meaning: meanings[index],
              onSynonymTap: _speek,
              onSynonymLongPress: (text) => _clipboard.copyWithSnakBar(context, text),
              onAntonymTap: _speek,
              onAntonymLongPress: (text) => _clipboard.copyWithSnakBar(context, text),
              onDefinitionTap: _speek,
              onDefinitionLongPress: (text) => _clipboard.copyWithSnakBar(context, text),
              onExampleTap: _speek,
              onExampleLongPress: (text) => _clipboard.copyWithSnakBar(context, text),
            );
          }),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Future _speek(String text) {
    return _textToSpeech.stopAndSpeek(text, language);
  }
}
