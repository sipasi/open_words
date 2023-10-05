import 'package:flutter/material.dart';
import 'package:open_words/data/language_info.dart';
import 'package:open_words/data/word/word_group.dart';

import 'word_group_edit_create_body.dart';

class WordGroupEditPage extends StatefulWidget {
  final WordGroup group;

  const WordGroupEditPage({super.key, required this.group});

  @override
  State<WordGroupEditPage> createState() => _WordGroupEditPageState();
}

class _WordGroupEditPageState extends State<WordGroupEditPage> {
  late final TextEditingController _nameController;

  late LanguageInfo origin;
  late LanguageInfo translation;

  @override
  void initState() {
    super.initState();

    final group = widget.group;

    _nameController = TextEditingController(text: group.name);

    origin = group.origin;
    translation = group.translation;
  }

  @override
  Widget build(BuildContext context) {
    return WordGroupEditCreateBody(
      name: _nameController,
      origin: origin,
      translation: translation,
      onSave: () {
        final name = _nameController.text;

        if (name.trim() == '') {
          return;
        }

        final now = DateTime.now();

        final group = widget.group.copyWith(
          modified: now,
          name: name,
          origin: origin,
          translation: translation,
        );

        Navigator.pop(context, group);
      },
      onOriginSelect: (origin) {
        setState(() {
          this.origin = origin;
        });
      },
      onTranslationSelect: (translation) {
        setState(() {
          this.translation = translation;
        });
      },
    );
  }
}
