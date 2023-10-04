import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:open_words/data/language_info.dart';
import 'package:open_words/data/word/word.dart';

import 'package:flutter_tts/flutter_tts.dart';

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

    final headlineMedium = theme.textTheme.headlineMedium;
    final headlineSmall = theme.textTheme.headlineSmall;

    final originStyle = headlineMedium?.copyWith(
      fontWeight: FontWeight.bold,
      color: theme.colorScheme.primary,
    );

    final translationStyle = headlineMedium?.copyWith(
      fontWeight: FontWeight.bold,
      color: theme.colorScheme.secondary,
    );

    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          const SizedBox(height: 10),
          ListTile(
            title: Text(word.origin, style: originStyle),
            trailing: const Icon(Icons.music_note),
            onTap: () => _textSynthesis(word.origin, originLanguage),
            onLongPress: () => _copyToClipboard(context, word.origin),
          ),
          ListTile(
            title: Text(word.translation, style: translationStyle),
            trailing: const Icon(Icons.music_note),
            onTap: () => _textSynthesis(word.translation, translationLanguage),
            onLongPress: () => _copyToClipboard(context, word.translation),
          ),
          const Divider(),
          ListTile(
            title: Text('Synonyms', style: headlineSmall),
            subtitle: Wrap(
              spacing: 16,
              children: [
                getTestActionChip(context, 'action', originLanguage),
                getTestActionChip(context, 'best', originLanguage),
                getTestActionChip(context, 'first', originLanguage),
              ],
            ),
          ),
          ListTile(
            title: Text('Antonyms', style: headlineSmall),
            subtitle: Wrap(
              spacing: 16,
              children: [
                getTestActionChip(context, 'action', originLanguage),
                getTestActionChip(context, 'best', originLanguage),
                getTestActionChip(context, 'first', originLanguage),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget getTestActionChip(BuildContext context, String text, LanguageInfo language) {
    return InkWell(
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      onTap: () => _textSynthesis(text, language),
      onLongPress: () => _copyToClipboard(context, text),
      child: Chip(
        label: Text(text),
      ),
    );
  }

  static Future _textSynthesis(String text, LanguageInfo language) async {
    FlutterTts tts = FlutterTts();

    tts.setLanguage(language.code);

    await tts.speak(text);
  }

  static void _copyToClipboard(BuildContext context, String text) {
    Future.sync(() async {
      await HapticFeedback.heavyImpact();

      await Clipboard.setData(ClipboardData(text: text));
    });

    final colors = Theme.of(context).colorScheme;

    final snackBar = SnackBar(
      content: Text(
        '$text copied',
        style: TextStyle(color: colors.primary),
      ),
      backgroundColor: colors.surfaceVariant,
      elevation: 0,
      showCloseIcon: true,
      closeIconColor: colors.error,
      duration: const Duration(seconds: 1),
    );

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
