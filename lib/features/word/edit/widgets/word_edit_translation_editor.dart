import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_words/features/word/edit/bloc/word_edit_bloc.dart';
import 'package:open_words/shared/input_fields/text_edit_controller.dart';
import 'package:open_words/shared/input_fields/text_edit_field.dart';

class WordEditTranslationEditor extends StatefulWidget {
  const WordEditTranslationEditor({super.key});

  @override
  State<WordEditTranslationEditor> createState() =>
      _WordEditTranslationEditorState();
}

class _WordEditTranslationEditorState extends State<WordEditTranslationEditor> {
  late final TextEditController translation;

  @override
  void initState() {
    super.initState();

    translation = TextEditController.text(
      text: context.read<WordEditBloc>().initialTranslation,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: TextEditField(
        controller: translation,
        border: OutlineInputBorder(),
        label: 'Translation',
        textInputAction: TextInputAction.done,
        onChanged: (value) {
          context.read<WordEditBloc>().add(WordEditTranslationChanged(value));
        },
      ),
    );
  }
}
