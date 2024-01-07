import 'package:flutter/material.dart';
import 'package:open_words/data/metadata/meaning.dart';
import 'package:open_words/data/metadata/word_metadata.dart';
import 'package:open_words/data/word/word.dart';
import 'package:open_words/view/shared/text/text_edit_field.dart';
import 'package:open_words/view/shared/text/text_edit_view_model.dart';
import 'package:open_words/view/word/edit/word_edit_view_model.dart';

class WordEditPage extends StatefulWidget {
  final String groupId;
  final int wordId;

  final Word word;
  final WordMetadata? metadata;

  const WordEditPage({
    super.key,
    required this.groupId,
    required this.wordId,
    required this.word,
    this.metadata,
  });

  @override
  State<WordEditPage> createState() => _WordEditPageState();
}

class _WordEditPageState extends State<WordEditPage> {
  late final WordEditViewModel viewmodel;

  @override
  void initState() {
    super.initState();
    WordMetadata? metadata = widget.metadata;

    viewmodel = WordEditViewModel(
      updateState: setState,
      groupId: widget.groupId,
      wordId: widget.wordId,
      index: widget.word.index,
      origin: widget.word.origin,
      translation: TextEditViewModel.text(text: widget.word.translation),
      phonetics: metadata?.phonetics.toList() ?? [],
      meanings: metadata?.meanings.toList() ?? [],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.word.origin),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton.extended(
            onPressed: () => viewmodel.createPhonetic(context),
            icon: const Icon(Icons.music_note),
            label: const Text('phonetic'),
            heroTag: 'save_phonetic_hero',
          ),
          const SizedBox(width: 10),
          FloatingActionButton.extended(
            onPressed: () => viewmodel.createMeaning(context),
            icon: const Icon(Icons.menu_book_outlined),
            label: const Text('meanings'),
            heroTag: 'save_meaning_hero',
          ),
          const SizedBox(width: 20),
          FloatingActionButton.extended(
            onPressed: () => viewmodel.save(context),
            label: const Text('Save'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextEditField(
                viewmodel: viewmodel.translation,
                onChanged: (value) => viewmodel.editTranslation(),
              ),
            ),
            const Divider(height: 40),
            _phoneticsList(),
            const Divider(height: 40),
            _meaningsList(),
          ],
        ),
      ),
    );
  }

  Widget _phoneticsList() {
    final theme = Theme.of(context);
    final boldStyle = theme.textTheme.headlineSmall?.copyWith(
      fontWeight: FontWeight.bold,
      color: theme.colorScheme.secondary,
    );

    if (viewmodel.phonetics.isNotEmpty) {
      return Column(
        children: [
          Text('Phonetics', style: boldStyle),
          Card(
            child: Column(
              children: List.generate(
                viewmodel.phonetics.length,
                (index) {
                  final entity = viewmodel.phonetics[index];

                  return ListTile(
                    title: Text(entity.value),
                    contentPadding: EdgeInsets.zero,
                    subtitle: entity.audio != null ? Text(entity.audio!) : null,
                    leading: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => viewmodel.removePhoneticAt(index),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () => viewmodel.editPhoneticAt(index, context),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      );
    }

    return _createFirstText('Phonetic');
  }

  Widget _meaningsList() {
    final theme = Theme.of(context);
    final boldStyle = theme.textTheme.headlineSmall?.copyWith(
      fontWeight: FontWeight.bold,
      color: theme.colorScheme.secondary,
    );

    if (viewmodel.meanings.isEmpty) {
      return _createFirstText('Meaning');
    }

    return Column(
      children: [
        Text('Meanings', style: boldStyle),
        Card(
          child: Column(
            children: List.generate(
              viewmodel.meanings.length,
              (index) {
                final entity = viewmodel.meanings[index];

                return _meaningTile(entity, index);
              },
            ),
          ),
        ),
      ],
    );
  }

  RichText _createFirstText(String text) {
    final theme = Theme.of(context);
    final boldStyle = theme.textTheme.headlineSmall?.copyWith(
      fontWeight: FontWeight.bold,
    );

    return RichText(
      text: TextSpan(children: [
        TextSpan(
          text: 'Create first ',
          style: boldStyle?.copyWith(color: theme.colorScheme.secondary),
        ),
        TextSpan(
          text: text,
          style: boldStyle?.copyWith(color: theme.colorScheme.primary),
        ),
      ]),
      textAlign: TextAlign.center,
    );
  }

  ListTile _meaningTile(Meaning entity, int index) {
    return ListTile(
      title: Text(entity.partOfSpeech),
      contentPadding: EdgeInsets.zero,
      titleAlignment: ListTileTitleAlignment.top,
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('synonyms: ${entity.synonyms.length}'),
          Text('antonyms: ${entity.antonyms.length}'),
          Text('definitions: ${entity.definitions.length}'),
        ],
      ),
      leading: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () {
          viewmodel.removeMeaningAt(index);
        },
      ),
      trailing: IconButton(
        icon: const Icon(Icons.edit),
        onPressed: () => viewmodel.editMeaningAt(index, context),
      ),
    );
  }
}
