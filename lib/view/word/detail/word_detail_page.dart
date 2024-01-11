import 'package:flutter/material.dart';
import 'package:open_words/data/language_info.dart';
import 'package:open_words/data/word/word.dart';
import 'package:open_words/view/mvvm/view_model.dart';
import 'package:open_words/view/word/detail/metadata/word_metadata_view.dart';

import 'word_detail_view_model.dart';

class WordDetailPage extends StatefulView<WordDetailViewModel> {
  final String groupId;
  final int wordId;

  final Word word;

  final LanguageInfo originLanguage;
  final LanguageInfo translationLanguage;

  const WordDetailPage({
    super.key,
    required this.groupId,
    required this.wordId,
    required this.word,
    required this.originLanguage,
    required this.translationLanguage,
  });

  @override
  ViewState<WordDetailViewModel> createState() => _WordDetailPageState();
}

class _WordDetailPageState extends ViewState<WordDetailViewModel> {
  @override
  WordDetailViewModel getViewmodel() {
    final parent = widget as WordDetailPage;

    return WordDetailViewModel(
      updateState: setState,
      groupId: parent.groupId,
      wordId: parent.wordId,
      word: parent.word,
      origin: parent.originLanguage,
      translation: parent.translationLanguage,
    );
  }

  @override
  Widget loading(BuildContext context) {
    return _scaffold(
      body: Column(
        children: [
          _header(),
          const LinearProgressIndicator(),
        ],
      ),
      fab: FloatingActionButton(
        onPressed: () {},
        child: const CircularProgressIndicator(),
      ),
    );
  }

  @override
  Widget success(BuildContext context) {
    return _scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _header(),
          const Divider(),
          WordMetadataView(metadata: viewmodel.metadata, language: viewmodel.origin),
          const SizedBox(height: 100),
        ],
      ),
      fab: FloatingActionButton(
        child: const Icon(Icons.edit_outlined),
        onPressed: () => viewmodel.edit(context),
      ),
    );
  }

  Widget _header() {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final headlineMedium = theme.textTheme.headlineMedium;

    final origin = headlineMedium?.copyWith(
      fontWeight: FontWeight.bold,
      color: colorScheme.primary,
    );

    final translation = headlineMedium?.copyWith(
      fontWeight: FontWeight.bold,
      color: colorScheme.secondary,
    );

    return Column(
      children: [
        ListTile(
          title: Text(viewmodel.word.origin, style: origin),
          trailing: const Icon(Icons.volume_up_sharp),
          onTap: () => viewmodel.textToSpeech.stopAndSpeek(viewmodel.word.origin, viewmodel.origin),
          onLongPress: () =>
              viewmodel.clipboard.writeText(context, viewmodel.word.origin, vibrate: true, snackBar: true),
        ),
        ListTile(
          title: Text(viewmodel.word.translation, style: translation),
          trailing: const Icon(Icons.volume_up_sharp),
          onTap: () => viewmodel.textToSpeech.stopAndSpeek(viewmodel.word.translation, viewmodel.translation),
          onLongPress: () =>
              viewmodel.clipboard.writeText(context, viewmodel.word.translation, vibrate: true, snackBar: true),
        ),
      ],
    );
  }

  Widget _scaffold({required Widget body, Widget? fab}) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () => viewmodel.delete(context),
            icon: const Icon(Icons.delete_forever_outlined),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: body,
      ),
      floatingActionButton: fab,
    );
  }
}
