import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:open_words/data/language_info.dart';
import 'package:open_words/data/metadata/definition.dart';
import 'package:open_words/data/metadata/meaning.dart';
import 'package:open_words/data/metadata/word_metadata.dart';
import 'package:open_words/data/metadata/word_metadata_genarator.dart';
import 'package:open_words/data/word/word.dart';
import 'package:open_words/service/clipboard_service.dart';
import 'package:open_words/service/text_to_speech_service.dart';

import 'package:open_words/view/word/detail/metadata/word_metadata_view.dart';

class WordDetailPage extends StatelessWidget {
  final Word word;

  final WordMetadata metadata = WordMetadataGenarator.get();

  final LanguageInfo originLanguage;
  final LanguageInfo translationLanguage;

  final TextToSpeechService _textToSpeech = GetIt.I.get<TextToSpeechService>();
  final ClipboardService _clipboard = GetIt.I.get<ClipboardService>();

  WordDetailPage({
    super.key,
    required this.word,
    required this.originLanguage,
    required this.translationLanguage,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final headlineMedium = theme.textTheme.headlineMedium;

    final originStyle = headlineMedium?.copyWith(
      fontWeight: FontWeight.bold,
      color: colorScheme.primary,
    );

    final translationStyle = headlineMedium?.copyWith(
      fontWeight: FontWeight.bold,
      color: colorScheme.secondary,
    );

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 10),
            ListTile(
              title: Text(word.origin, style: originStyle),
              trailing: const Icon(Icons.volume_up_sharp),
              onTap: () => _textToSpeech.stopAndSpeek(word.origin, originLanguage),
              onLongPress: () => _clipboard.copyWithSnakBar(context, word.origin),
            ),
            ListTile(
              title: Text(word.translation, style: translationStyle),
              trailing: const Icon(Icons.volume_up_sharp),
              onTap: () => _textToSpeech.stopAndSpeek(word.translation, translationLanguage),
              onLongPress: () => _clipboard.copyWithSnakBar(context, word.translation),
            ),
            const Divider(),
            WordMetadataView(
              metadata: metadata,
              language: originLanguage,
            ),
          ],
        ),
      ),
    );
  }
}
