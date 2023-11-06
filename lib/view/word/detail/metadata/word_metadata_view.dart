import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:open_words/data/language_info.dart';
import 'package:open_words/data/metadata/meaning.dart';
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
    return _column(context);
  }

  Widget _column(BuildContext context) {
    final meanings = metadata.meanings;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ...List.generate(meanings.length, (index) {
            return Column(
              children: [
                if (index != 0) const Divider(),
                _getMeaningView(context, meanings[index]),
              ],
            );
          }),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _getMeaningView(BuildContext context, Meaning meaning) {
    return MeaningView(
      meaning: meaning,
      onSynonymTap: _speek,
      onSynonymLongPress: (text) => _clipboard.copyWithSnakBar(context, text),
      onAntonymTap: _speek,
      onAntonymLongPress: (text) => _clipboard.copyWithSnakBar(context, text),
      onDefinitionTap: _speek,
      onDefinitionLongPress: (text) => _clipboard.copyWithSnakBar(context, text),
      onExampleTap: _speek,
      onExampleLongPress: (text) => _clipboard.copyWithSnakBar(context, text),
    );
  }

  Future _speek(String text) {
    return _textToSpeech.stopAndSpeek(text, language);
  }
}
