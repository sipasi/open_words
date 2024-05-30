import 'package:flutter/material.dart';
import 'package:open_words/data/word/word_group.dart';
import 'package:open_words/view/shared/text/text_edit_view_model.dart';

import 'word_group_edit_create_body.dart';
import 'word_group_edit_view_model.dart';

class WordGroupEditPage extends StatefulWidget {
  final WordGroup group;

  const WordGroupEditPage({super.key, required this.group});

  @override
  State<WordGroupEditPage> createState() => _WordGroupEditPageState();
}

class _WordGroupEditPageState extends State<WordGroupEditPage> {
  late final WordGroupEditViewModel viewmodel;

  @override
  void initState() {
    super.initState();

    final group = widget.group;

    viewmodel = WordGroupEditViewModel(
      group,
      TextEditViewModel.text(text: group.name),
      group.origin,
      group.translation,
    );
  }

  @override
  Widget build(BuildContext context) {
    return WordGroupEditCreateBody(
      name: viewmodel.name,
      origin: viewmodel.origin,
      translation: viewmodel.translation,
      onSave: () => viewmodel.onSave(context),
      onNameChange: (value) => viewmodel.onNameChange(setState),
      onOriginSelect: (origin) => viewmodel.onOriginSelect(origin, setState),
      onTranslationSelect: (translation) => viewmodel.onTranslationSelect(translation, setState),
    );
  }
}
