import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:open_words/data/language_info.dart';
import 'package:open_words/data/word/word_group.dart';
import 'package:open_words/service/language/language_info_service.dart';
import 'package:uuid/uuid.dart';

import 'word_group_edit_create_body.dart';

class WordGroupCreatePage extends StatefulWidget {
  const WordGroupCreatePage({super.key});

  @override
  State<WordGroupCreatePage> createState() => _WordGroupCreatePageState();
}

class _WordGroupCreatePageState extends State<WordGroupCreatePage> {
  late final TextEditingController _nameController;

  late final LanguageInfo origin;
  late final LanguageInfo translation;

  @override
  void initState() {
    super.initState();

    final service = GetIt.I.get<LanguageInfoService>();

    _nameController = TextEditingController();
    origin = service.getByCode('en');
    translation = service.getByCode('uk');
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

        final group = WordGroup(
          id: const Uuid().v4(),
          created: now,
          modified: now,
          name: name,
          origin: origin,
          translation: translation,
          words: [],
          index: 0,
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
