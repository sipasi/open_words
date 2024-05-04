import 'package:flutter/material.dart';
import 'package:open_words/data/language_info.dart';
import 'package:open_words/data/word/word.dart';
import 'package:open_words/view/mvvm/view_model.dart';
import 'package:open_words/view/shared/navigation/on_pop_return.dart';
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
    return _Body(
      viewmodel: viewmodel,
      fab: FloatingActionButton(
        onPressed: () {},
        child: const CircularProgressIndicator(),
      ),
      child: Column(
        children: [
          _Header(viewmodel: viewmodel),
          const LinearProgressIndicator(),
        ],
      ),
    );
  }

  @override
  Widget success(BuildContext context) {
    return _Body(
      viewmodel: viewmodel,
      fab: FloatingActionButton(
        child: const Icon(Icons.edit_outlined),
        onPressed: () => viewmodel.edit(context),
      ),
      child: OnPopReturn<Word>(
        value: () => viewmodel.word,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _Header(viewmodel: viewmodel),
            const Divider(),
            WordMetadataView(metadata: viewmodel.metadata, language: viewmodel.origin),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final WordDetailViewModel viewmodel;

  const _Header({required this.viewmodel});

  @override
  Widget build(BuildContext context) {
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

    final word = viewmodel.word;
    final textToSpeech = viewmodel.textToSpeech;
    final clipboard = viewmodel.clipboard;
    final originLanguage = viewmodel.origin;
    final translationLanguage = viewmodel.translation;

    return Column(
      children: [
        ListTile(
          title: Text(word.origin, style: origin),
          trailing: const Icon(Icons.volume_up_sharp),
          onTap: () => textToSpeech.stopAndSpeek(word.origin, originLanguage),
          onLongPress: () => clipboard.writeText(context, word.origin, vibrate: true, snackBar: true),
        ),
        ListTile(
          title: Text(word.translation, style: translation),
          trailing: const Icon(Icons.volume_up_sharp),
          onTap: () => textToSpeech.stopAndSpeek(word.translation, translationLanguage),
          onLongPress: () => clipboard.writeText(context, word.translation, vibrate: true, snackBar: true),
        ),
      ],
    );
  }
}

class _Body extends StatelessWidget {
  final WordDetailViewModel viewmodel;
  final Widget child;
  final Widget? fab;

  const _Body({required this.viewmodel, required this.child, this.fab});

  @override
  Widget build(BuildContext context) {
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
        child: child,
      ),
      floatingActionButton: fab,
    );
  }
}
