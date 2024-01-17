import 'package:flutter/material.dart';
import 'package:open_words/data/language_info.dart';
import 'package:open_words/data/word/word_group.dart';
import 'package:open_words/service/navigation/material_navigator.dart';
import 'package:open_words/service/result.dart';
import 'package:open_words/view/shared/text/text_edit_view_model.dart';

import 'word_group_edit_create_body.dart';

class WordGroupEditPage extends StatefulWidget {
  final WordGroup group;

  const WordGroupEditPage({super.key, required this.group});

  @override
  State<WordGroupEditPage> createState() => _WordGroupEditPageState();
}

class _WordGroupEditPageState extends State<WordGroupEditPage> {
  late final TextEditViewModel _name;

  late LanguageInfo origin;
  late LanguageInfo translation;

  @override
  void initState() {
    super.initState();

    final group = widget.group;

    _name = TextEditViewModel.text(text: group.name);

    origin = group.origin;
    translation = group.translation;
  }

  @override
  Widget build(BuildContext context) {
    return WordGroupEditCreateBody(
      name: _name,
      origin: origin,
      translation: translation,
      onSave: () {
        final name = _name.textTrim;

        if (name.isEmpty) {
          return;
        }

        final now = DateTime.now();

        final group = widget.group.copyWith(
          modified: now,
          name: name,
          origin: origin,
          translation: translation,
        );

        MaterialNavigator.popWith(context, CrudResult.modify(group));
      },
      onNameChange: (value) => TextEditViewModel.setErrorIfEmpty(_name, setState),
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
