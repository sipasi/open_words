import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:open_words/data/language_info.dart';
import 'package:open_words/data/word/word.dart';
import 'package:open_words/service/clipboard_service.dart';
import 'package:open_words/service/navigation/material_navigator.dart';
import 'package:open_words/service/text_to_speech_service.dart';
import 'package:open_words/view/word/detail/metadata/word_metadata_loader_view.dart';
import 'package:open_words/view/word/edit/word_edit_page.dart';

class WordDetailPage extends StatelessWidget {
  final Word word;

  final LanguageInfo originLanguage;
  final LanguageInfo translationLanguage;

  const WordDetailPage({
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

    final textToSpeech = GetIt.I.get<TextToSpeechService>();

    final clipboard = GetIt.I.get<ClipboardService>();

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
              onTap: () => textToSpeech.stopAndSpeek(word.origin, originLanguage),
              onLongPress: () => clipboard.copyWithSnakBar(context, word.origin),
            ),
            ListTile(
              title: Text(word.translation, style: translationStyle),
              trailing: const Icon(Icons.volume_up_sharp),
              onTap: () => textToSpeech.stopAndSpeek(word.translation, translationLanguage),
              onLongPress: () => clipboard.copyWithSnakBar(context, word.translation),
            ),
            const Divider(),
            WordMetadataLoaderView(
              word: word.origin,
              language: originLanguage,
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.edit_outlined),
        onPressed: () {
          MaterialNavigator.push(context, (context) => const WordEditPage());
        },
      ),
    );
  }
}
