import 'package:flutter/material.dart';
import 'package:open_words/data/language_info.dart';
import 'package:open_words/view/word_group/edit/language_selector_tile.dart';

class WordGroupEditCreateBody extends StatelessWidget {
  final TextEditingController name;

  final LanguageInfo origin;
  final LanguageInfo translation;

  final void Function() onSave;
  final void Function(LanguageInfo origin) onOriginSelect;
  final void Function(LanguageInfo translation) onTranslationSelect;

  const WordGroupEditCreateBody({
    super.key,
    required this.name,
    required this.origin,
    required this.translation,
    required this.onSave,
    required this.onOriginSelect,
    required this.onTranslationSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name.text),
        actions: [
          IconButton(
            icon: const Icon(Icons.save_outlined),
            onPressed: onSave,
          )
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TextField(
              controller: name,
              decoration: const InputDecoration(
                hintText: 'Enter name',
                labelText: 'Name',
              ),
            ),
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
    );
  }
}
