import 'package:flutter/material.dart';
import 'package:open_words/data/language_info.dart';
import 'package:open_words/view/shared/text/text_edit_card.dart';
import 'package:open_words/view/shared/text/text_edit_view_model.dart';
import 'package:open_words/view/word_group/edit/language_selector_tile.dart';

class WordGroupEditCreateBody extends StatelessWidget {
  final TextEditViewModel name;

  final LanguageInfo origin;
  final LanguageInfo translation;

  final void Function() onSave;
  final void Function(String value) onNameChange;
  final void Function(LanguageInfo origin) onOriginSelect;
  final void Function(LanguageInfo translation) onTranslationSelect;

  const WordGroupEditCreateBody({
    super.key,
    required this.name,
    required this.origin,
    required this.translation,
    required this.onSave,
    required this.onNameChange,
    required this.onOriginSelect,
    required this.onTranslationSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name.text),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        children: [
          TextEditCard(
            viewmodel: name,
            hint: 'name',
            onClear: () => name.clear(),
            onChange: onNameChange,
            onCopy: () => name.copyToClipboard(context),
            onPaste: () => name.pasteFromClipboard(context),
          ),
          const SizedBox(height: 10),
          LanguageSelectorTile(
            title: 'Origin',
            language: origin,
            selected: (value) => onOriginSelect(value),
          ),
          LanguageSelectorTile(
            title: 'Translation',
            language: translation,
            selected: (value) => onTranslationSelect(value),
          ),
          const SizedBox(height: 10),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Save'),
        icon: const Icon(Icons.save),
        onPressed: onSave,
      ),
    );
  }
}
