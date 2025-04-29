import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_words/features/word/edit/bloc/word_edit_bloc.dart';
import 'package:open_words/shared/input_fields/text_edit_controller.dart';
import 'package:open_words/shared/input_fields/text_edit_field.dart';

class WordEditEtymologyEditor extends StatefulWidget {
  const WordEditEtymologyEditor({super.key});

  @override
  State<WordEditEtymologyEditor> createState() =>
      _WordEditEtymologyEditorState();
}

class _WordEditEtymologyEditorState extends State<WordEditEtymologyEditor> {
  late final TextEditController translation;

  @override
  void initState() {
    super.initState();

    translation = TextEditController.text(
      text: context.read<WordEditBloc>().initialMetadata.etymology,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: TextEditField(
        controller: translation,
        border: OutlineInputBorder(),
        label: 'Etymology',
        textInputAction: TextInputAction.done,
        onChanged: (value) {
          context.read<WordEditBloc>().add(WordEditEtymologyChanged(value));
        },
      ),
    );
  }
}
