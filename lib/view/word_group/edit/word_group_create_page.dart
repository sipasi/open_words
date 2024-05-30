import 'package:flutter/material.dart';

import 'word_group_create_view_model.dart';
import 'word_group_edit_create_body.dart';

class WordGroupCreatePage extends StatefulWidget {
  const WordGroupCreatePage({super.key});

  @override
  State<WordGroupCreatePage> createState() => _WordGroupCreatePageState();
}

class _WordGroupCreatePageState extends State<WordGroupCreatePage> {
  late final WordGroupCreateViewModel viewmodel;

  @override
  void initState() {
    super.initState();

    viewmodel = WordGroupCreateViewModel.create();
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
      onTranslationSelect: (translation) => viewmodel.onOriginSelect(translation, setState),
    );
  }
}
